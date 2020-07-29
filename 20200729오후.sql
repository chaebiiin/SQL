--오후

set serveroutput on
set autoprint on
--RECORD
DECLARE
TYPE t_rec IS RECORD
      (v_sal number(8),
      v_minsal number(8) default 1000,
      v_hire_date employees.hire_date%type,
      v_rec1 employees%rowtype);
      v_myrec t_rec;
BEGIN
      v_myrec.v_sal := v_myrec.v_minsal + 500;
      v_myrec.v_hire_date := sysdate;
      SELECT * INTO v_myrec.v_rec1
            FROM employees WHERE employee_id = 100;
      DBMS_OUTPUT.PUT_LINE(v_myrec.v_rec1.last_name ||' '||
                                          to_char(v_myrec.v_hire_date) ||' '|| to_char(v_myrec.v_sal));
END;
/
--아래의 실습을 위한 테이블 생성
create table retired_emps(empno, ename, job, mgr, hiredate, leavedate, sal, comm, deptno)
as
select employee_id, last_name, job_id, manager_id, hire_date,sysdate,salary, commission_pct, department_id 
from employees
where employee_id = 0;

DECLARE
v_employee_number number:= 149;
--테이블안에 있는 칼럼을 통채로 가지고 와서 변수에 담는다. 
-- 테이블의 있는 컬럼을 가지고 와서 레코드로 인식한다? 앞에 있는 변수에 바로 인식 시켜준다. ?????? 
v_emp_rec employees%ROWTYPE;
BEGIN
SELECT * INTO v_emp_rec FROM employees
WHERE employee_id = v_employee_number;
INSERT INTO retired_emps(empno, ename, job, mgr,
hiredate, leavedate, sal, comm, deptno)
VALUES (v_emp_rec.employee_id, v_emp_rec.last_name,
v_emp_rec.job_id, v_emp_rec.manager_id,
v_emp_rec.hire_date, SYSDATE,
v_emp_rec.salary, v_emp_rec.commission_pct,
v_emp_rec.department_id);
END;
/
select * from retired_emps;

--PL/SQL TABLE 
DECLARE
TYPE dept_table_type IS TABLE OF
departments%ROWTYPE INDEX BY PLS_INTEGER;
dept_table dept_table_type;
-- Each element of dept_table is a record
Begin
SELECT * INTO dept_table(5) FROM departments
WHERE department_id = 80;
DBMS_OUTPUT.PUT_LINE(dept_table(5).department_id ||', ' ||
dept_table(5).department_name ||', ' ||
dept_table(5).manager_id);
END;
/
select * from departments;


  
DECLARE   
  TYPE emp_table_type IS TABLE OF
      employees%ROWTYPE INDEX BY PLS_INTEGER;  --pl/sql 테이블 선언 
  my_emp_table emp_table_type;
  max_count number(3):= 104;
BEGIN
  for i IN 100 .. max_count  --i는 100~ 104까지 반복하면서
  LOOP
    select * INTO my_emp_table(i) from employees --100부터 데이터를 가지고 온 걸 my_emp_table에 담음. 
    where employee_id=i; --my_emp_table에 100부터 104까지 담김
    END LOOP; --출력을 위한 for
    for i in my_emp_table.FIRST..my_emp_table.LAST  --my_emp_table에 들어 있는 제일 첫번째 인덱스부터 가지고 온다.(100) 
    LOOP
      DBMS_OUTPUT.PUT_LINE(my_emp_table(i).department_id); --테이블에 있는 last_name을 가지고 온다. 
   END LOOP;
END;
/

DECLARE
   TYPE dept_table_type IS TABLE OF NUMBER
         INDEX BY BINARY_INTEGER;
    dept_table dept_table_type;
     v_total NUMBER;
    BEGIN
         FOR i IN 1..50 LOOP
              dept_table(i) := i;
        END LOOP;
          v_total := dept_table.COUNT;
        DBMS_OUTPUT.PUT_LINE(v_total);
 END;
 /
 
 DECLARE
    TYPE test_table_type IS TABLE OF VARCHAR2(10)
         INDEX BY BINARY_INTEGER;
      test_table test_table_type;
  BEGIN
    test_table(1) := 'One';
    test_table(3) := 'Three';
    test_table(-2) := 'Minus Two';
    test_table(0) := 'Zero';
    test_table(100) := 'Hundred';
    DBMS_OUTPUT.PUT_LINE(test_table(1));
    DBMS_OUTPUT.PUT_LINE(test_table(3));
    DBMS_OUTPUT.PUT_LINE(test_table(-2));
    DBMS_OUTPUT.PUT_LINE(test_table(0));
    DBMS_OUTPUT.PUT_LINE(test_table(100));
    
    test_table.DELETE(100);
    test_table.DELETE(1,3);
    test_table.DELETE;
    
  DBMS_OUTPUT.PUT_LINE('------------------');
 END;
 /
 create table emp(empid number(5), empname varchar2(20));
 
 
 DECLARE 
      TYPE emp_table_type IS TABLE OF VARCHAR2(13)
              INDEX BY BINARY_INTEGER;
          emp_table emp_table_type;
       BEGIN
          emp_table(1) := 'SCOTT';
          emp_table(3) := 'JONE';
          DBMS_OUTPUT.PUT_LINE(emp_table(1));
          DBMS_OUTPUT.PUT_LINE(emp_table(3));
          IF emp_table.EXISTS(1) THEN
              INSERT INTO emp(empid, empname)
              VALUES (100, 'Row 1 있음');
          ELSE
               INSERT INTO emp(empid, empname)
              VALUES (100, 'Row 1 없음');
          END IF;
          IF emp_table.EXISTS(2) THEN
              INSERT INTO emp(empid, empname)
              VALUES (200, 'Row 2 있음');
           ELSE
               INSERT INTO emp(empid, empname)
               VALUES (200, 'Row 2 없음');
          END IF;
          IF emp_table.EXISTS(3) THEN
              INSERT INTO emp(empid, empname)
              VALUES (300, 'Row 3 있음');
           ELSE
               INSERT INTO emp(empid, empname)
               VALUES (300, 'Row 3 없음');
          END IF;
       END;
     /  
SELECT * FROM emp;          