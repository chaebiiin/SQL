SET serveroutput ON
SET autoprint ON
/*����2. HR ������� ���̺��� �����͸� �̿��Ͽ� ����� id�� �Է¹޾� ����� id, job_id,�޿�, ���� �Ѽ����� ����Ͻÿ�.
�޿��� Ŀ�̼��� null�� ���� ���� ��µǵ���.
*/

DECLARE 
    v_input NUMBER;
    v_empid employees.employee_id%type;
    v_job_id employees.job_id%type;
    v_salary employees.salary%type;
    v_sumsal employees.salary%type;
BEGIN
    SELECT employee_id, job_id, salary,salary*(nvl(COMMISSION_PCT,0)+1)*12 
    INTO v_empid, v_job_id,v_salary, v_sumsal
    FROM employees  
    WHERE employee_id=&v_input;
     DBMS_OUTPUT.PUT_LINE(v_empid ||', '|| v_job_id ||', '|| v_salary ||', '|| v_sumsal);
END;
 /

/* ����3.hr.employees���� Ư������� �Ի�⵵�� 2005�� ���Ŀ� �Ի�� 'new employee' �ƴϸ� 'career employee'�̶�� ���*/
DECLARE
  v_input NUMBER;
  v_empid employees.hire_date%type;  
BEGIN
    SELECT hire_date 
    INTO v_empid
    FROM employees 
    WHERE employee_id= &v_input;
        DBMS_OUTPUT.PUT_LINE(v_empid);

      IF  v_empid > TO_DATE('20050101','yyyy/mm/dd')
       THEN 
        DBMS_OUTPUT.PUT_LINE('new employee');
      ELSE
        DBMS_OUTPUT.PUT_LINE('career employee');
  END IF;
END;
/

/*����4. ������ 1��~ 9���� ����ϴµ� Ȧ�� �ܸ� ����Ͻÿ�.*/
BEGIN
  FOR i in 1..9 LOOP
    IF mod(i,2)=1 THEN
       DBMS_OUTPUT.PUT_LINE('---------------------');
        DBMS_OUTPUT.PUT_LINE('<' ||i || '��>');
        
        FOR j IN 1..9 LOOP
           DBMS_OUTPUT.PUT_LINE(i ||'x' || j || '= ' || (i*j));
         END LOOP;  
    END IF;  
  END LOOP;
END;
/

/* ����5. �μ���ȣ�� �Է��ϸ� �ش� �μ��� �ٹ��ϴ� ����� ���, �̸�, �޿��� ��µǵ���  */
CREATE OR REPLACE PROCEDURE select_deptno
        (p_departmentid IN  NUMBER)
        IS             
         CURSOR c_emp_cursor(p_departmentid NUMBER) IS
             SELECT employee_id, last_name, salary  
             FROM employees
             WHERE department_id = p_departmentid;
                 emp_record c_emp_cursor%ROWTYPE;
        
BEGIN 
       FOR emp_record IN c_emp_cursor(p_departmentid) LOOP
        DBMS_OUTPUT.PUT_LINE( emp_record.employee_id ||' , ' ||emp_record.last_name ||', '||emp_record.salary);
      END LOOP;        
END select_deptno;
/

EXECUTE select_deptno(90);

/*����6. �λ��� ������ ���Ǹ� ���� �������� ���, �޿� ����ġ�� �Է��ϸ� Employees ���̺� ���� ����� �޿��� ���� �� �� �ֵ��� 
            ���α׷��� �ۼ��Ͻÿ�. ���� �Է��� ����� ���� ��쿡�� 'No Search Employee!!' ��� �޼����� ����ϼ���.*/
            
CREATE OR REPLACE PROCEDURE raise_salary   
    (v_empid IN employees.employee_id%TYPE, 
      p_percent IN NUMBER)
  IS
    e_invalid_department EXCEPTION;
BEGIN
      UPDATE employees
      SET salary = salary * (1 + p_percent/100)
      WHERE employee_id = v_empid;
       IF SQL%NOTFOUND THEN 
            RAISE e_invalid_department;
         END IF;
  
EXCEPTION
    WHEN e_invalid_department THEN
      DBMS_OUTPUT.PUT_LINE('No Search Employee!!');
END raise_salary; 
/
EXECUTE raise_salary(&v_empid, &p_percent);         
SELECT * FROM employees WHERE employee_id=176;

/* ����7. �ֹε�Ϲ�ȣ�� �Է¹����� 9911021234567�� �Է¹޾� 991102-1******�� ����ϴ� ���α׷��� �ۼ�*/
DECLARE
    v_number VARCHAR(20) := &v_number;
BEGIN
    v_number := SUBSTR(v_number, 1, 6) || '-' || SUBSTR(v_number, 7, 1) || '******';
      DBMS_OUTPUT.PUT_LINE(v_number);
END;
/
/*����8. ���̸� �Է��ϰų� ��������� �Է��ϸ� �츦 ����ϴ� chinese_zodiac package�� �����Ͻÿ�. 
            overload ���
            (mouse, cow,rabbit, dragon, snake,horse, sheep, monky, rooster, dog, pig) */

DECLARE
		v_year number(4) := 1992;
		v_ani number(2) := mod(v_year, 12); /*����������*/
	BEGIN
      IF v_ani = 0 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� �����̶� �Դϴ�');
      ELSIF v_ani = 1 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� �߶� �Դϴ�');
      ELSIF v_ani = 2 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ���� �Դϴ�');
      ELSIF v_ani = 3 THEN
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ������ �Դϴ�');
      ELSIF v_ani = 4 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ��� �Դϴ�');
      ELSIF v_ani = 5 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� �Ҷ� �Դϴ�');
      ELSIF v_ani = 6 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ȣ���̶� �Դϴ�');
      ELSIF v_ani = 7 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� �䳢�� �Դϴ�');
      ELSIF v_ani = 8 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ��� �Դϴ�');
      ELSIF v_ani = 9 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ��� �Դϴ�');
      ELSIF v_ani = 10 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ���� �Դϴ�');
      ELSIF v_ani = 11 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'�⵵ ���� ��� �Դϴ�');
      END IF;
	END;
	/


/*����9/ HR����ڿ��� �����ϴ� PROCEDURE, FUNCTION, PACKAGE, PACKAGE BODY�� �̸��� �ҽ��ڵ带 Ȯ���ϴ� SQL ������ �ۼ��Ͻÿ�.*/
SELECT text
FROM user_source
WHERE name = 'ADD_DEPT' AND type = 'PROCEDURE'
ORDER BY line;

SELECT text
FROM user_source
WHERE name = 'INC_SAL' AND type = 'FUNCTION'
ORDER BY line;

SELECT text
FROM user_source
WHERE name = 'COMM_PKG' AND type = 'PACKAGE'
ORDER BY line;

SELECT text
FROM user_source
WHERE name = 'COMM_PKG' AND type = 'PACKAGE BODY'
ORDER BY line;

SELECT * FROM user_source;

/*����10. 
---------*
--------**
-------***
------****
-----*****
----******
---*******
--********
-*********
���� ��� ��� */

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(lpad(rpad('*', i, '*'), 11, '-'));
    END LOOP;
END;
/