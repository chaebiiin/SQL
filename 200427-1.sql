--session 1
--tr ����
INSERT INTO dept
VALUES (70, 'Public Relations', 100, 1700);
-- �μ���ȣ 70�� �Է��ϱ�
SELECT * FROM dept;

INSERT INTO dept(department_name, department_id)
VALUES('Parchasing', 30);

SELECT * FROM dept;
DESC dept;

INSERT INTO dept
VALUES(100, 'Finance', null, null);
SELECT * FROM dept;

COMMIT; --���ε�(?)
--tr ��

SELECT * FROM emp;

UPDATE emp
SET salary=salary*1.1, department_id = 20;
--�μ���ȣ�� 20������ �ٲٰ�, �޿��� 10%�λ�

ROLLBACK;

UPDATE emp
SET salary=salary*1.1, department_id = 20
WHERE employee_id = 200; -- <-�ٲ� �� ����
-- 200����� �μ���ȣ�� 20�� �ٲٰ�, �޿��� 10%�� �λ�

UPDATE emp
SET salary = salary+1000
WHERE employee_id = 201;

CREATE TABLE sales_reps
AS
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE 1=2;
-- CREATE TABLE(DDL ����)�� �����ϸ� �ڵ����� Ŀ���� �� ��0��!
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
VALUES(231, '����', '��', 'KSH', '555.248.4265', TO_DATE('24-04-99','dd-mm-yy'), 
              'AC_ACCOUNT', 6900, NULL, 205, 110);

INSERT INTO emp
VALUES(232, '����', '��', 'PNL', '555.705.4265', TO_DATE('24-04-99','dd-mm-rr'), 
              'AC_ACCOUNT', 7900, NULL, 205, 110);
SELECT * FROM emp;
 
ROLLBACK;              
--���

UPDATE emp
SET department_id = 10
WHERE employee_id = 201;
--201�� ����� �μ���ȣ�� 10���� �ٲ�
COMMIT;

DESC sales_reps;

INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

SELECT * FROM sales_reps;

--INSERT INTO () VALUES �� �ѹ��� �Է°��� // INSERT INTO () SELECT ������ ����?