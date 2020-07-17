SELECT employee_id, TO_CHAR(hire_date, 'yyyy/mm/dd hh24:mi:ss')
FROM employees;
--�Լ�(TO_DATE)(������, '����')

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
            TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')
from dual;
SELECT last_name,
            TO_CHAR(hire_date, 'fmday month yyyy')
            AS HIREDATE
FROM employees;

SELECT employee_id, last_name, TO_CHAR(salary,'$9,999,999') AS salary
FROM employees;
-- $�ȿ� 0����  ä��� �տ� �ڸ����� 0���� ä����, 9�� �ڷ��� �ݾ׿� �°� ä����, 

--TO_DATE�� WHERE�� ����
SELECT employee_id, last_name, TO_CHAR(salary,'$99,999') AS salary
FROM employees
WHERE salary > TO_NUMBER('8,000','9,999');
--TO_NUMBER('8,000','9,999'); ���ڷ� �νĽ����ִ� �Լ�

SELECT employee_id, last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01-01-1999', 'dd-mm-yyyy');

SELECT employee_id, last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01-01-1999', 'dd-mm-rr');
--rr(00~49, 50~99 �������� 00~49�� ���� ���⸦ ��Ÿ����, 50~99�� ���� ���⸦ ��Ÿ��)�� yy(���缼�⸦ ��Ÿ����)

SELECT employee_id, last_name, NVL(manager_id, 8888)
FROM employees;
--NVL NULL ���� �ִ� Į���� ���� �ٸ� �ɷ� ��ġ�ؼ� ��Ÿ�� ��
SELECT employee_id, last_name, NVL(TO_CHAR(manager_id), 'No Manager')
FROM employees;
DESC employees;
--���ڴ� ����ȭ�� ����, ���ڴ� ����ȭ�� �Ұ��� 

SELECT employee_id, last_name, 
             salary+salary*NVL(commission_pct,0) AS monthly_sal
FROM employees;

SELECT employee_id, last_name, 
             salary+salary*NVL(commission_pct,0) AS monthly_sal,
             NVL2(commission_pct, 'Y', 'N') AS bigo
FROM employees;
--Null���� �ִ��� ������ Ȯ���ϴ� �Լ�

SELECT NULLIF(1,1), NULLIF(2,1)
from dual;
-- �� �μ��� ������(����� ������) NULL�� ��µǰ�, �� �μ��� �ٸ��� �տ� �Էµ� �����Ͱ� ��µǾ ����

SELECT employee_id, commission_pct, manager_id,
             COALESCE(commission_pct, manager_id, 99)
FROM employees;

-------------------------------���б��� ^^7!!

SELECT last_name, job_id, salary,
             CASE job_id WHEN 'IT_PROG' THEN 1.1*salary
                               WHEN 'ST_CLERK' THEN 1.15*salary
                               WHEN 'SA_REP' THEN 1.2*salary
                     ELSE salary
             END AS "Revised Salary"
FROM employees;

SELECT last_name, job_id, salary,
             CASE WHEN job_id = 'IT_PROG' THEN 1.1*salary
                      WHEN job_id = 'ST_CLERK' THEN 1.15*salary
                      WHEN job_id = 'SA_REP' THEN 1.2*salary
                     ELSE salary
             END AS "Revised Salary"
FROM employees;

--�޿��� 5000�̸��̸� 20�ۼ�Ʈ �λ�, �޿��� 5000�̻� 10000�����̸� 15�ۼ�Ʈ �λ�, �޿��� 10000�ʰ��̸� 10�ۼ�Ʈ �λ�� ���
SELECT last_name, job_id,salary,
            CASE WHEN salary < 5000 THEN 1.2*salary
                     WHEN salary BETWEEN 5000 AND 10000 THEN 1.15*salary
                     WHEN salary >10000 THEN 1.1*salary
            END AS "Revised SALARY"
FROM employees;
--job_id�� CASE WHEN **** (***�̸�) THEN **** (***�����ش�.) END AS ***** (��°��� "****"�� ��Ÿ����)

SELECT employee_id, last_name, 
             salary+salary*NVL(commission_pct,0) AS monthly_sal,
             CASE WHEN commission_pct IS NOT NULL THEN 'Y'
                      ELSE 'N' END AS "bigo"
FROM employees;

SELECT last_name, job_id, salary,
             DECODE(job_id, 'IT_PROG', 1.10*salary,
                                   'ST_CLERK', 1.15*salary,
                                   'SA_REP', 1.20*salary,
                        salary)
               REVISED_SALARY
 FROM     employees;     
 
 
 --------------------5��--�׷�׷�׷�׷� �������Լ�������!----------------
SELECT AVG(salary), SUM(salary), MIN(salary), MAX(salary)
FROM employees;
--AVG(���), SUM(�հ�), MIN(�ּҰ�), MAX(�ִ밪)

SELECT TRUNC(AVG(salary)), SUM(salary), MIN(salary), MAX(salary)
FROM employees
WHERE department_id = 80;
--TRUNC�� �Ҽ��� ���� �� �� ����, �հ�� ����� ���ڷ� ���� ��, 

SELECT MIN(last_name), MAX(last_name)
FROM employees;
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;
--MIN, MAX COUNT ��絥���� Ÿ���� ������

SELECT AVG(commission_pct), AVG(NVL(commission_pct,0))
FROM employees;
--Ŀ�̼� �޴� ����� ������ ����� �ű�, Ŀ�̼��� �޴»���� �ƴѻ�� ��� �����Ͽ� ����� �ű�, �׷��Լ��� NULL���� ���� ���, 

SELECT department_id, AVG(salary)
FROM employees;

SELECT COUNT(*),COUNT(department_id), COUNT(DISTINCT department_id)
FROM employees;
--COUNT �� (*) <-���̺��� ��� �ľ�, (DISTINCE(�ߺ�����))�� ���� �� ����.

SELECT department_id, COUNT(*), TRUNC(AVG(salary))
FROM employees
WHERE department_id IN (50,60)
GROUP BY department_id
ORDER BY 3 DESC;

SELECT department_id, COUNT(*), TRUNC(AVG(salary))
FROM employees 
WHERE last_name LIKE '%a%'
GROUP BY department_id
HAVING count(*) >= 3 
ORDER BY 3 DESC;
-- HAVING �׷��� ����� ������, WHERE�� ���� ������,  WHERE�� �׻� FROM �ڿ� �;� �Ѵ�.

SELECT department_id, job_id, COUNT(*), TRUNC(AVG(salary))
FROM employees 
GROUP BY department_id, job_id
ORDER BY 1,2;

