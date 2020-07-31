SET serveroutput ON
SET autoprint ON
/*문제2. HR 사용자의 테이블의 데이터를 이용하여 사원의 id를 입력받아 사원의 id, job_id,급여, 연간 총수입을 출력하시오.
급여나 커미션이 null일 경우라도 값이 출력되도록.
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

/* 문제3.hr.employees에서 특정사원의 입사년도가 2005년 이후에 입사면 'new employee' 아니면 'career employee'이라고 출력*/
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

/*문제4. 구구단 1단~ 9단을 출력하는데 홀수 단만 출력하시오.*/
BEGIN
  FOR i in 1..9 LOOP
    IF mod(i,2)=1 THEN
       DBMS_OUTPUT.PUT_LINE('---------------------');
        DBMS_OUTPUT.PUT_LINE('<' ||i || '단>');
        
        FOR j IN 1..9 LOOP
           DBMS_OUTPUT.PUT_LINE(i ||'x' || j || '= ' || (i*j));
         END LOOP;  
    END IF;  
  END LOOP;
END;
/

/* 문제5. 부서번호를 입력하면 해당 부서에 근무하는 사원의 사번, 이름, 급여를 출력되도록  */
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

/*문제6. 인사팀 직원의 편의를 위해 직원들이 사번, 급여 증가치만 입력하면 Employees 테이블에 쉽게 사원의 급여를 갱신 할 수 있도록 
            프로그램을 작성하시오. 만약 입력한 사원이 없는 경우에는 'No Search Employee!!' 라는 메세지를 출력하세요.*/
            
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

/* 문제7. 주민등록번호를 입력받으면 9911021234567를 입력받아 991102-1******로 출력하는 프로그램을 작성*/
DECLARE
    v_number VARCHAR(20) := &v_number;
BEGIN
    v_number := SUBSTR(v_number, 1, 6) || '-' || SUBSTR(v_number, 7, 1) || '******';
      DBMS_OUTPUT.PUT_LINE(v_number);
END;
/
/*문제8. 나이를 입력하거나 생년월일을 입력하면 띠를 출력하는 chinese_zodiac package를 생성하시오. 
            overload 사용
            (mouse, cow,rabbit, dragon, snake,horse, sheep, monky, rooster, dog, pig) */

DECLARE
		v_year number(4) := 1992;
		v_ani number(2) := mod(v_year, 12); /*나머지구함*/
	BEGIN
      IF v_ani = 0 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 원숭이띠 입니다');
      ELSIF v_ani = 1 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 닭띠 입니다');
      ELSIF v_ani = 2 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 개띠 입니다');
      ELSIF v_ani = 3 THEN
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 돼지띠 입니다');
      ELSIF v_ani = 4 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 쥐띠 입니다');
      ELSIF v_ani = 5 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 소띠 입니다');
      ELSIF v_ani = 6 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 호랑이띠 입니다');
      ELSIF v_ani = 7 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 토끼띠 입니다');
      ELSIF v_ani = 8 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 용띠 입니다');
      ELSIF v_ani = 9 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 뱀띠 입니다');
      ELSIF v_ani = 10 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 말띠 입니다');
      ELSIF v_ani = 11 THEN 
      DBMS_OUTPUT.PUT_LINE(v_year||'년도 생은 양띠 입니다');
      END IF;
	END;
	/


/*문제9/ HR사용자에게 존재하는 PROCEDURE, FUNCTION, PACKAGE, PACKAGE BODY의 이름과 소스코드를 확인하는 SQL 구문을 작성하시오.*/
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

/*문제10. 
---------*
--------**
-------***
------****
-----*****
----******
---*******
--********
-*********
위의 모양 출력 */

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(lpad(rpad('*', i, '*'), 11, '-'));
    END LOOP;
END;
/