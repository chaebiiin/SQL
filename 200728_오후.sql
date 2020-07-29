--오전수업 이어서 ~ 
set serveroutput on
set autoprint on
DECLARE
    v_weight NUMBER(3) := 600;
    v_message VARCHAR2(255):='Product 10012';
BEGIN
  DECLARE
    v_weight NUMBER(7,2) := 50000;
   v_message VARCHAR2(255) := 'Product 11001';
   v_new_locn VARCHAR2(50) := 'Europe';
BEGIN
  v_weight := v_weight + 1;
  v_new_locn := 'Western' || v_new_locn;
DBMS_OUTPUT.PUT_LINE('v_weight1: ' ||v_weight);
DBMS_OUTPUT.PUT_LINE('v_message1: ' ||v_message);
DBMS_OUTPUT.PUT_LINE('v_new_locn1: ' ||v_new_locn);
DBMS_OUTPUT.PUT_LINE('========================');
END;
  v_weight := v_weight + 1;
  v_message := v_message || ' + is in stock';
  DBMS_OUTPUT.PUT_LINE('v_weight2: ' ||v_weight);
DBMS_OUTPUT.PUT_LINE('v_message2: ' ||v_message);
 --v_new_locn := 'Western'|| v_new_locn;
END;
/

/*
하위블록
v_weight ->50001
v_message ->Product 11001
v_new_locn ->  WesternEurope

상위블록
v_weight ->601
v_message -> Product 10012 + is in stock
v_new_locn -> 실행 안 됨 오류
*/


--PL/SQL의 SELECT문
DECLARE
v_fname VARCHAR2(25);
BEGIN
    SELECT first_name 
    INTO v_fname
    FROM employees 
    WHERE employee_id in(176,200);
DBMS_OUTPUT.PUT_LINE('First Name is :  '||v_fname);
END;
/
--쿼리된 결과가 아무 값도 없다면 NO_DATA_FOUND
--너무 많은 결과가 나온다면 TOO_MANY_ROWS 

--
DECLARE
v_emp_hiredate employees.hire_date%TYPE; --%TYPE 앞의 컬럼과 같은 타입으로 받아오겠다.
v_emp_salary employees.salary%TYPE;
BEGIN
SELECT hire_date, salary --select 2개
INTO v_emp_hiredate, v_emp_salary --select에 칼럼이 2개이면 변수도 2개 받아와야 하고, 변수의 순서도 같게 적어줘야 한다. 
FROM employees
WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE ('Hire date is: '|| v_emp_hiredate);
DBMS_OUTPUT.PUT_LINE ('Salary is : '|| v_emp_salary);
END;
/
select * from employees
where employee_id =100;

--select 안에서는 그룹함수가 사용가능하다. 
declare
  v_sum_sal number(10,2);
  v_deptno number not null := 60;
 begin 
 select sum(salary)
 into v_sum_sal from employees
 where department_id = v_deptno;
 dbms_output.put_line(v_sum_sal);
 end;
 /
 
DECLARE
v_hire_date employees.hire_date%TYPE;
v_sysdate employees.hire_date%TYPE;
v_employee_id employees.employee_id%TYPE := 176;
BEGIN
SELECT hire_date, sysdate
INTO v_hire_date, v_sysdate
FROM employees
WHERE v_employee_id =employee_id;
dbms_output.put_line('employee_id: '||v_employee_id);
END;
/


BEGIN
INSERT INTO employees
(employee_id, first_name, last_name, email,
hire_date, job_id, salary)
VALUES(employees_seq.NEXTVAL, 'Ruth', 'Cores',
'RCORES',CURRENT_DATE, 'AD_ASST', 4000);
END;
/

select employee_id, first_name, last_name, email, hire_date, job_id, salary from employees;
 
 DECLARE
sal_increase employees.salary%TYPE := 800;
BEGIN
UPDATE employees
SET salary = salary + sal_increase
WHERE job_id = 'ST_CLERK';
dbms_output.put_line(sal_increase);
END;
/
rollback;
 
DECLARE
emp employees.employee_id%TYPE := 380;
BEGIN
DELETE FROM employees
WHERE employee_id = emp;
dbms_output.put_line(emp);
END;
/ 

begin
delete from employees
where employee_id =382;
end;
/

-- SQL커서 속성
declare
v_rows_deleted varchar2(30);
v_empno employees.employee_id%type :=383;
begin
delete from employees
where employee_id = v_empno;
v_rows_deleted :=(SQL%rowcount || 'row deleted');
dbms_output.put_line(v_rows_deleted);
end;
/

-- IF문
--단순 IF문
declare
  v_marge number := 10;
  begin
    if v_marge <11
    then 
    dbms_output.put_line('yes!');
end if;
end;
/

--IF-Then-Else!
DECLARE
v_myage number:=11;
BEGIN
IF v_myage < 11 --조건
THEN
    dbms_output.put_line('yes!'); -- 만족하면 이거 출력
ELSE
   dbms_output.put_line('no!'); -- 아니면 이거 출력
END IF;
dbms_output.put_line('-------------');
END;
/

DECLARE
v_myage number:=9; -- 초기값?
BEGIN
IF v_myage < 11 THEN  -- 11보다 작으면 nooo
DBMS_OUTPUT.PUT_LINE('noooo ');
ELSIF v_myage < 20 THEN --20보다 작으면 noo
DBMS_OUTPUT.PUT_LINE(' noo ');
ELSIF v_myage < 30 THEN --30보다 작으면 
DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
ELSIF v_myage < 40 THEN --40보다 작으면
DBMS_OUTPUT.PUT_LINE(' I am in my thirties');
ELSE --위의 조건중 맞는게 없다면 
DBMS_OUTPUT.PUT_LINE(' I am always young ');
END IF;
END;
/

--LOOP~
DECLARE
  v_countryid locations.country_id%TYPE := 'UK';
  v_loc_id locations.location_id%TYPE;
  v_counter NUMBER(2) := 1;
  v_new_city locations.city%TYPE := 'Montreal';

BEGIN
  SELECT MAX(location_id) INTO v_loc_id FROM locations  
  WHERE country_id = v_countryid; --중복값 제거를 위해 사용 
  LOOP
    INSERT INTO locations(location_id, city, country_id)
    VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
                  v_counter := v_counter + 1;
    EXIT WHEN v_counter > 3;
    END LOOP;
END;
/
select * from locations;

rollback;