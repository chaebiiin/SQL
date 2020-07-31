--200731수업
set serveroutput on
set autoprint on

CREATE OR REPLACE FUNCTION get_sal
    (p_id employees.employee_id%TYPE) RETURN NUMBER IS --IN이 생략 된 상태
      v_sal employees.salary%TYPE := 0;
          BEGIN
              SELECT salary
              INTO v_sal
              FROM employees
              WHERE employee_id = p_id;
              RETURN v_sal;
          END get_sal;
 /         
 
 EXECUTE dbms_output.put_line(get_sal(100)); --p_id에 100이 들어 감.
 select salary from employees where employee_id = 100;
 

--위에서 만든 FUNCTION을 불러와서 사용.
DECLARE  
    sal employees.salary%TYPE;
BEGIN
    sal := get_sal(100);
    DBMS_OUTPUT.PUT_LINE('The salary is: ' || sal);
END;
/

--위에서 만든 FUNCTION은 select하는데서 사용 할 수 있다. 
SELECT job_id, get_sal(employee_id)
FROM employees;

--함수 만들기~ p_value*0.08한 값이 tax에 담김)
CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER)
  RETURN NUMBER IS
BEGIN
    RETURN (p_value * 0.08);
END tax;
/

SELECT employee_id, last_name, salary, tax(salary)
FROM employees
WHERE department_id = 90;
    
/*  문제1. inc_sal 함수 생성, 
            급여가 5000이하이면 20% 인상된 급여 
            급여가 10000이하이면 15% 인상된 급여
            급여가 150000이하이면 10% 인상된 급여
            급여가 150000이상이면 급여 인상 없음
       사원번호를 입력하면 인상된 급여가 출력되도록 inc_sal 함수를 생성하시오.    */
       
CREATE OR REPLACE FUNCTION inc_sal
  (v_empid employees.employee_id%TYPE) RETURN NUMBER IS 
      v_sal employees.salary%TYPE := 0;
BEGIN
  SELECT 
       (CASE WHEN salary <=5000 THEN salary*1.20   
                WHEN salary <=10000 THEN salary*1.15
               WHEN salary <=15000 THEN salary*1.10
              ELSE salary
         END) "annual" INTO v_sal
FROM employees
WHERE employee_id = v_empid;
      RETURN v_sal;
END inc_sal;
/

EXECUTE dbms_output.put_line(inc_sal(176));      
select salary from employees
where employee_id = 174;

-- 문제1을 IF문을 사용해서 풀이 
 CREATE OR REPLACE FUNCTION inc_sal1
    (v_empid employees.employee_id%TYPE) RETURN NUMBER IS 
      v_sal employees.salary%TYPE := 0;
   BEGIN
    SELECT salary INTO v_sal
    FROM employees
    WHERE employee_id = v_empid;
    
      IF v_sal <= 5000 then return v_sal * 1.20;
      ELSIF v_sal <=10000 then return v_sal * 1.15;
      ELSIF v_sal <=15000 then return v_sal * 1.10;
      ELSE  return v_sal ;
      END IF;
    END inc_sal1;
/   

EXECUTE dbms_output.put_line(inc_sal1(176));      
select salary from employees
where employee_id = 174;


SELECT text
FROM user_source
WHERE name = 'ADD_DEPT' AND type = 'PROCEDURE'
ORDER BY line;

----------------------------------------------------------------------------------
--PACKAGE (인터페이스와 클래스 관계와 비슷하다.)
CREATE OR REPLACE PACKAGE comm_pkg IS
      v_std_comm NUMBER := 0.10; --공용변수 초기값은 0.10
      PROCEDURE reset_comm(p_new_comm NUMBER); --공용프로시져 선언
END comm_pkg;
/

--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY comm_pkg IS

    FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS --validate함수 생성 (전용 함수) /p_comm는 매개변수
        v_max_comm employees.commission_pct%type; --지역변수 선언
        
BEGIN
      SELECT MAX(commission_pct) INTO v_max_comm --기존의 커미션의 최대값이 v_max_comm에 들어감.
      FROM employees;
      RETURN (p_comm BETWEEN 0.0 AND v_max_comm); --값이 포함되면 true를 리턴한다. 
END validate;
   
   PROCEDURE reset_comm(p_new_comm NUMBER) IS --(공용 프로시져) validate 함수는 여기 안에서만 사용 가능
 
   BEGIN
      IF validate(p_new_comm) THEN -- validate 함수호출 
         v_std_comm := p_new_comm; --true이면 입력한 값이 위의 함수에 들어감?
       ELSE RAISE_APPLICATION_ERROR(
                      -20210, 'Bad Commission');
      END IF;
    END reset_comm;
 END comm_pkg;   
 /
 --          패키지명. 공용변수(값)
 EXECUTE comm_pkg.reset_comm(0.15);
 ----------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE global_consts IS
    mile_2_kilo CONSTANT NUMBER := 1.6093;
    kilo_2_mile CONSTANT NUMBER := 0.6214;
    yard_2_meter CONSTANT NUMBER := 0.9144;
    meter_2_yard CONSTANT NUMBER := 1.0936;
END global_consts;
/
EXECUTE DBMS_OUTPUT.PUT_LINE('20 miles = ' || -20*global_consts.mile_2_kilo || ' km');


----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE meter_to_yard
      (p_meter IN NUMBER,
          p_yard OUT NUMBER)
                    IS
BEGIN
        p_yard := p_meter * global_consts.meter_2_yard;
END meter_to_yard;
/
VARIABLE yard NUMBER
EXECUTE meter_to_yard (1, :yard);
PRINT yard;
----------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE dept_pkg IS
  PROCEDURE add_department
        (p_deptno departments.department_id%TYPE,
        p_name departments.department_name%TYPE :='unknown',
        p_loc departments.location_id%TYPE := 1700);
        
      PROCEDURE add_department
       (p_name departments.department_name%TYPE :='unknown',
          p_loc departments.location_id%TYPE := 1700);
    END dept_pkg;
/    

CREATE OR REPLACE PACKAGE BODY dept_pkg IS

    PROCEDURE add_department --1번째 프로시져 
      (p_deptno departments.department_id%TYPE,
      p_name departments.department_name%TYPE := 'unknown',
      p_loc departments.location_id%TYPE := 1700) IS
BEGIN
    INSERT INTO departments(department_id, department_name, location_id)
                VALUES (p_deptno, p_name, p_loc);
END add_department;

      PROCEDURE add_department --2번째 프로시져
        (p_name departments.department_name%TYPE := 'unknown',
          p_loc departments.location_id%TYPE := 1700) IS
BEGIN
    INSERT INTO departments (department_id, department_name, location_id)
                VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_department;
END dept_pkg; 
/

EXECUTE dept_pkg.add_department(980,'Education',2500);

SELECT * FROM departments
WHERE department_id = 980;




-----------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE curs_pkg IS 
    PROCEDURE open;
      FUNCTION next(p_n NUMBER := 1) RETURN BOOLEAN;
    PROCEDURE close;
END curs_pkg;
/
CREATE OR REPLACE PACKAGE BODY curs_pkg IS

    CURSOR cur_c IS
      SELECT employee_id FROM employees;
        PROCEDURE open IS
    BEGIN
          IF NOT cur_c%ISOPEN THEN
    OPEN cur_c;
          END IF;
    END open;
    
FUNCTION next(p_n NUMBER := 1) RETURN BOOLEAN IS
    v_emp_id employees.employee_id%TYPE;
BEGIN
    FOR count IN 1 .. p_n LOOP
      FETCH cur_c INTO v_emp_id;
      EXIT WHEN cur_c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Id: ' ||v_emp_id);
    END LOOP;
  RETURN cur_c%FOUND;
END next;
PROCEDURE close IS
  BEGIN
    IF cur_c%ISOPEN THEN
      CLOSE cur_c;
    END IF;
  END close;
END curs_pkg;
/

EXECUTE curs_pkg.open;

DECLARE 
  v_more BOOLEAN := curs_pkg.next(3);
BEGIN
    IF NOT v_more THEN
      curs_pkg.close;
     END IF;
END;
/

/* 문제2. 부서번호를 입력하면 해당 부서에 근무하는 사원의 사번, 이름, 급여를 출력하는 FUNCTION을 작성하세요. */

CREATE OR REPLACE PROCEDURE select_deptno
        (p_departmentid IN  NUMBER)
          
         IS             
         CURSOR c_emp_cursor(p_departmentid NUMBER) IS
             SELECT employee_id, last_name, salary  
             FROM employees
            WHERE department_id = p_departmentid;
        emp_record c_emp_cursor%ROWTYPE;
        
       BEGIN 
       FOR emp_record IN c_emp_cursor(p_departmentid)
        LOOP
        DBMS_OUTPUT.PUT_LINE( emp_record.employee_id ||' , ' ||emp_record.last_name ||', '||emp_record.salary);
      END LOOP;
         
END select_deptno;
/
EXECUTE select_deptno(90);




/* 문제 3. 사원의 사번을 입력으로 받으면 근무한 년수를 출력하는 Function을 작성하세요. */
--SELECT last_name, trunc(months_between(sysdate, hire_date)/12, 0) "년" from employees;

CREATE OR REPLACE  FUNCTION  get_hiredate
      (p_employeeid employees.employee_id%TYPE)
      RETURN NUMBER IS
       v_hiredate NUMBER(10);
     BEGIN
        SELECT trunc(months_between(sysdate, hire_date)/12, 0) "년" 
        INTO v_hiredate
        FROM employees
         WHERE employee_id = p_employeeid;
      RETURN v_hiredate;
  END get_hiredate;
/

EXECUTE dbms_output.put_line(get_hiredate(176));

--오후수업
--TRIGGER
CREATE OR REPLACE TRIGGER secure_emp
    BEFORE INSERT ON employees
  BEGIN
      IF (TO_CHAR(SYSDATE,'DY') IN ('토','일')) OR
          (TO_CHAR(SYSDATE,'HH24:MI')
          NOT BETWEEN '08:00' AND '18:00') THEN
    RAISE_APPLICATION_ERROR(-20500, 'You may insert  into EMPLOYEES table only during normal business hours.');
    END IF;
END;
/
desc employees;
select * FROM employees;

INSERT INTO employees 
VALUES(280, 'Ravi', 'kim', 'ravi0215', '010-1234-5678', sysdate,'MK_REP', 25000, null, 100,90, null);
-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER secure_emp BEFORE
    INSERT OR UPDATE OR DELETE ON employees
BEGIN
      IF (TO_CHAR(SYSDATE,'DY') IN ('토','일')) OR (TO_CHAR(SYSDATE,'HH24')
          NOT BETWEEN '08' AND '18') THEN
              IF DELETING THEN RAISE_APPLICATION_ERROR(-20502,'You may delete from EMPLOYEES table only during normal business hours.');
              
              ELSIF INSERTING THEN RAISE_APPLICATION_ERROR(-20500,'You may insert into EMPLOYEES table only during normal business hours.');
             
              ELSIF UPDATING ('SALARY') THEN RAISE_APPLICATION_ERROR(-20503, 'You may update SALARY only normal during business hours.');
             
              ELSE RAISE_APPLICATION_ERROR(-20504,'You may update EMPLOYEES table only during normal business hours.');
            END IF;
            END IF;
END;
/
------------------------------------------------------------------------------------------------------------------------
UPDATE employees set salary = salary*1.1;


CREATE TABLE audit_emp (
      user_name VARCHAR2(30),
      time_stamp date,
      id NUMBER(6),
      old_last_name VARCHAR2(25),
      new_last_name VARCHAR2(25),
      old_title VARCHAR2(10),
      new_title VARCHAR2(10),
      old_salary NUMBER(8,2),
      new_salary NUMBER(8,2))
/

CREATE OR REPLACE TRIGGER audit_emp_values
    AFTER DELETE OR INSERT OR UPDATE ON employees
      FOR EACH ROW
BEGIN
    INSERT INTO audit_emp(user_name, time_stamp, id,old_last_name, new_last_name, old_title, new_title, old_salary, new_salary)
    VALUES (USER, SYSDATE, :OLD.employee_id,:OLD.last_name, :NEW.last_name, :OLD.job_id,:NEW.job_id, :OLD.salary, :NEW.salary);
END;
/

select * from employees;

INSERT INTO employees 
VALUES(283, 'HYUK', 'Han', 'hyuk0705', '010-1234-5678', sysdate,'SA_MAN', 25000, null, 100,90, null);

UPDATE employees set salary = salary*1.1
where employee_id = 281;
ALTER TABLE employees disable all TRIGGERS;
