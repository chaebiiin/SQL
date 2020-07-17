SELECT * FROM employees
WHERE last_name = 'King';

CREATE INDEX emp_lastname_idx
ON employees(last_name);

SELECT INDEX_name
FROM USER_indexes
WHERE table_name = 'EMP10';
--EMPLOYEES���̺� ���� �� �ε����� Ȯ��
CREATE TABLE emp10
(empid NUMBER(4) PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp10_ename_uk UNIQUE,
email VARCHAR2(50));
CREATE INDEX emp10_email_ix ON emp10(email);
--�ε��� �����
DROP INDEX emp10_email_ix;
--�ε��� ����
DROP INDEX emp10_ename_uk;

SELECT VIEW_name FROM user_views;

SELECT * FROM emp_dept_loc_join_vu;

CREATE SYNONYM list for emp_dept_loc_join_vu;
--��Ī����
SELECT * FROM list;
DROP SYNONYM list;
--��Ī�����ϱ�


--2�ܿ�..;

SELECT * FROM session_privs;
GRANT select ON hr.employees TO om;
--om���� employees ���̺��� �� �� �ִ� ����� ������ ��;
GRANT update ON hr.employees TO om;
REVOKE select on hr.employees FROM om;
REVOKE update ON hr.employees FROM om;
--�ο� �� �� ������ �ٽ� ȸ��

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
--���� ��Ī �����... ���� ���뺰Ī ���� �� �ִ� �����ֱ�...

REVOKE SELECT ON hr.emp_list_5080_vu FROM om;
--���� ȸ��
GRANT SELECT ON hr.emp_list_5080_vu TO om;
--���Ѻο�
DROP VIEW emp_list_5080_vu;
--�� ����











--�ֹ� ����â ��
SELECT * FROM hr.employees;
UPDATE hr.employees
SET salary = salary*1.1;
ROLLBACK;

SELECT * FROM hr.emp_list_5080_vu;
CREATE SYNONYM emp FOR hr.emp_list_5080_vu;
--��Ī ����
SELECT * FROM emp;
--������ ��Ī���� SELECT
SELECT * FROM hr.dept_list_vu;
SELECT * FROM d;



