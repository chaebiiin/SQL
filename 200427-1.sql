--session 1
--tr 시작
INSERT INTO dept
VALUES (70, 'Public Relations', 100, 1700);
-- 부서번호 70번 입력하기
SELECT * FROM dept;

INSERT INTO dept(department_name, department_id)
VALUES('Parchasing', 30);

SELECT * FROM dept;
DESC dept;

INSERT INTO dept
VALUES(100, 'Finance', null, null);
SELECT * FROM dept;

COMMIT; --업로드(?)
--tr 끝

SELECT * FROM emp;

UPDATE emp
SET salary=salary*1.1, department_id = 20;
--부서번호를 20번으로 바꾸고, 급여를 10%인상

ROLLBACK;

UPDATE emp
SET salary=salary*1.1, department_id = 20
WHERE employee_id = 200; -- <-바꿀 곳 지정
-- 200사원의 부서번호를 20을 바꾸고, 급여를 10%로 인상

UPDATE emp
SET salary = salary+1000
WHERE employee_id = 201;

CREATE TABLE sales_reps
AS
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE 1=2;
-- CREATE TABLE(DDL 실행)을 실행하면 자동으로 커밋이 됨 ㅠ0ㅠ!
SELECT * FROM sales_reps;

-----------------------------------------session 2----------------------------------------
SELECT * FROM dept;

INSERT INTO dept
VALUES(200, 'Service', null, null);

SELECT *
FROM dept;

INSERT INTO emp
VALUES(113, 'Louis', 'Popp', 'LPOPP', '513.234.4567', sysdate, 'AC_ACCOUNT', 6900, NULL, 205, 110);
SELECT *
FROM emp;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy/mm/dd hh24:mm:ss') AS hiredate
FROM emp;

COMMIt;
SELECT * FROM dept;

INSERT INTO emp
VALUES(231, '수현', '김', 'KSH', '555.248.4265', TO_DATE('24-04-99','dd-mm-yy'), 
              'AC_ACCOUNT', 6900, NULL, 205, 110);

INSERT INTO emp
VALUES(232, '나래', '박', 'PNL', '555.705.4265', TO_DATE('24-04-99','dd-mm-rr'), 
              'AC_ACCOUNT', 7900, NULL, 205, 110);
SELECT * FROM emp;
 
ROLLBACK;              
--취소

UPDATE emp
SET department_id = 10
WHERE employee_id = 201;
--201번 사원의 부서번호를 10으로 바꿈
COMMIT;

DESC sales_reps;

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

SELECT * FROM sales_reps;

--INSERT INTO () VALUES 는 한번만 입력가능 // INSERT INTO () SELECT 여러번 가능?