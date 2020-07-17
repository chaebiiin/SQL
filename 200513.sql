(i1 INTERVAL year to month,
i2 INTERVAL day to second);

INSERT INTO service
VALUES(INTERVAL '3-5' year to month, INTERVAL '90 12:30:00' day to second);
--3���ϰ� 5���� // 90�� 12��30��00��
COMMIT;

SELECT * FROM service;
--���� ���...
SELECT id,ord_d1 �ֹ���¥, ADD_MONTHS(ord_d1, 41) "���� ������"
FROM orders;
-- �ֹ���¥���� 3�� 5���� �� �� ��, �ֹ���¥���� 90��, 12��30�� 00�� ���� ��
SELECT id, ord_d2 �ֹ���¥, ord_d1+i1 ����������, ord_d1+i2 "��ǰ��� ������"
FROM orders, service;

SELECT employee_id, last_name, hire_date �Ի���, hire_date+i1 "�Ի� �� 3�� 5���� ��"
FROM employees, service;
DESC service;




--������� �Ի��� �� ��ȸ
SELECT employee_id, last_name, TO_CHAR(hire_date, 'mm') "�Ի� �� "
FROM employees;
--EXTRACT�� ����ؼ� ������� �Ի��� �� ��ȸ
SELECT employee_id, last_name, EXTRACT(month FROM hire_date)
FROM employees;

SELECT TZ_OFFSET('Asia/Seoul') FROM dual;

DROP TABLE emp purge;

CREATE TABLE emp
AS
SELECT employee_id, last_name, salary, hire_date
FROM employees;
SELECT * FROM emp;

--emp���̺��� ������ Ÿ���� �ٲ㼭 ��Ÿ����
ALTER TABLE myemp
MODIFY hire_date timestamp;

--query �ϴ� ���ȿ��� ������ Ÿ���� �ٲ㼭 ������?
SELECT employee_id, last_name, FROM_TZ(hire_date, 'Asia/Seoul')
FROM emp;
SELECT employee_id, last_name, FROM_TZ(hire_date, '+9:00')
FROM emp;

--TO_YMINTERVAL�� �̿�
SELECT hire_date, hire_date + to_YMINTERVAL('01-02') "1�� 2���� ��"
FROM employees
WHERE department_id = 20;

--TO_DSINTERVAL�� �̿�
ALTER TABLE employees
MODIFY hire_date timestamp;
SELECT last_name,hire_date, hire_date+TO_DSINTERVAL('100 10:00:00') "100�� 10�ð� ��"
FROM employees;

--Abel�� ���޺��� ���� �޴� ��� ã��
SELECT * FROM employees
WHERE salary >(SELECT salary FROM employees
                      WHERE last_name = 'Abel');

--emp                     
@C:\oraclexe\labs\cre_empl.sql

-- sqlå 6-5 �ǽ�
SELECT* FROM empl_demo;
--������ �μ���ȣ�� �Ŵ��� ��ȣ�� ���� ��� ã��
SELECT employee_id, manager_id, department_id, last_name FROM empl_demo
WHERE first_name = 'John';
-- ������(�Ŵ��� ��ȣ�� �μ���ȣ�� ������) ����
--�ڱ� �ڽ��� �����Ϸ��� AND ~ �� ������ ����. 
SELECT employee_id, manager_id, department_id, last_name
FROM empl_demo
WHERE(manager_id, department_id) IN
                              (SELECT manager_id, department_id
                              FROM empl_demo
                              WHERE first_name = 'John')
AND first_name <> 'John';

-- sql å 6-6 �ǽ�
-- �Ŵ��� ��ȣ ������ ���� �μ���ȣ ������ ���� �ؼ� ã��
SELECT employee_id, manager_id, department_id, last_name
FROM empl_demo
WHERE manager_id IN
                            (SELECT manager_id
                            FROM empl_demo
                            WHERE first_name = 'John')
AND department_id IN  
                          (SELECT department_id
                          FROM empl_demo
                          WHERE first_name = 'John')
AND first_name <> 'John';       
-- sql å 6-11 �ǽ�
-- ���� �μ���ȣ�� �ܺ����̺� �ִ� �μ���ȣ�� ����, 
--�μ��� ��ձ޿��� �μ������ ���� ���� ���ؼ� ���ǿ� �´�(��ձ޿����� �� ū �ָ� ���) ���� ���
SELECT last_name, salary, department_id
FROM employees o -- ���ܺ����̺�
WHERE salary > ( SELECT AVG(salary) FROM employees i
                        WHERE i.department_id = o.department_id);

SELECT last_name, salary, department_id
FROM employees
WHERE salary > ANY (SELECT AVG(salary) FROM employees
                      GROUP BY department_id);
                      
--�μ��� ��� �޿�
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id;

--�ҼӺμ��� ��ձ޿����� �� ���� �޴� ��� ����ϱ�
SELECT a.employee_id, a.last_name, a.salary, a.department_id, b.avgsal
FROM employees a JOIN (SELECT department_id, AVG(salary) avgsal FROM employees
                                  GROUP BY department_id) b
                                  ON(a.department_id = b.department_id)
WHERE a. salary > b.avgsal;
-- sql 6-15 �ǽ�
SELECT employee_id, last_name, job_id, department_id
FROM employees o
WHERE EXISTS (SELECT 'X'
                        FROM employees
                        WHERE manager_id = o.employee_id);
                        
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS ( SELECT ' X'
                                FROM employees
                                WHERE department_id = d.department_id);
--���̺� ���� �� Į�� �߰�
CREATE TABLE emp6
as
SELECT employee_id, last_name, department_id
FROM employees;

ALTER TABLE emp6
ADD POSITION VARCHAR2(10);

SELECT * FROM emp6;

--�߰� �� Į���� ����� ������ job_id�� �Է��ؼ� ������Ʈ ���ֱ� (��ȣ���� ������Ʈ...) sql å 6-18 �ǽ�
UPDATE emp6
SET position = (SELECT job_id FROM employees
                      WHERE employee_id = emp6.employee_id);



WITH 
dept_costs AS (
      SELECT d.department_name, SUM(e.salary) as dept_total
      FROM employees e JOIN departments d
      ON e.department_id = d. department_id
      GROUP BY d.department_name),
avg_cost  AS (
      SELECT sum(dept_total)/COUNT(*) AS dept_avg
      FROM dept_costs)
SELECT *
FROM dept_costs
WHERE dept_total >
              (SELECT dept_avg
              FROM avg_cost)
ORDER BY department_name;              
                      
@C:\oraclexe\labs\regexp_tab.sql
SELECT * FROM t1;

--���� �����ϱ� ��, sql 1�� 3�ܿ� (������ �Լ�)
--SUBSTR
--INSTR
--REPLACE
-- 2�ܿ��� LIKE ������ 
--���� ���� ���� ���� �غ���....