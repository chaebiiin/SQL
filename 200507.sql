SELECT * FROM employees
WHERE last_name = 'King';

CREATE INDEX emp_lastname_idx
ON employees(last_name);

SELECT INDEX_name
FROM USER_indexes
WHERE table_name = 'EMP10';
--EMPLOYEES테이블에 저장 된 인덱스들 확인
CREATE TABLE emp10
(empid NUMBER(4) PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp10_ename_uk UNIQUE,
email VARCHAR2(50));
CREATE INDEX emp10_email_ix ON emp10(email);
--인덱스 만들기
DROP INDEX emp10_email_ix;
--인덱스 삭제
DROP INDEX emp10_ename_uk;

SELECT VIEW_name FROM user_views;

SELECT * FROM emp_dept_loc_join_vu;

CREATE SYNONYM list for emp_dept_loc_join_vu;
--별칭적기
SELECT * FROM list;
DROP SYNONYM list;
--별칭삭제하기


--2단원..;

SELECT * FROM session_privs;
GRANT select ON hr.employees TO om;
--om에게 employees 테이블을 볼 수 있는 사용자 권한을 줌;
GRANT update ON hr.employees TO om;
REVOKE select on hr.employees FROM om;
REVOKE update ON hr.employees FROM om;
--부여 해 준 권한을 다시 회수

CREATE VIEW emp_list_5080_vu
AS
SELECT employee_id empno, CONCAT(first_name, CONCAT('  ',last_name))ename, email, department_id
FROM employees
WHERE department_id BETWEEN 50 AND 80;

SELECT * FROM emp_list_5080_vu;
GRANT select ON hr.emp_list_5080_vu TO om;

CREATE VIEW dept_list_vu
AS
SELECT department_id deptno, department_name dept_name, city
FROM departments JOIN locations
USING (location_id);

GRANT SELECT ON hr.dept_list_vu TO public;

CREATE PUBLIC SYNONYM d FOR hr.dept_list_vu;
--공용 별칭 만들기... 먼저 공용별칭 만들 수 있는 권한주기...

REVOKE SELECT ON hr.emp_list_5080_vu FROM om;
--권한 회수
GRANT SELECT ON hr.emp_list_5080_vu TO om;
--권한부여
DROP VIEW emp_list_5080_vu;
--뷰 삭제











--주문 관리창 ▽
SELECT * FROM hr.employees;
UPDATE hr.employees
SET salary = salary*1.1;
ROLLBACK;

SELECT * FROM hr.emp_list_5080_vu;
CREATE SYNONYM emp FOR hr.emp_list_5080_vu;
--별칭 지정
SELECT * FROM emp;
--지정된 별칭으로 SELECT
SELECT * FROM hr.dept_list_vu;
SELECT * FROM d;



