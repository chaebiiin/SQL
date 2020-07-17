SELECT *
FROM departments;

DESC departments 

SELECT employee_id �����ȣ, last_name �̸�, job_id �μ��ڵ�, hire_date �Ի���
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT employee_id  AS  "emp #", last_name employee, job_id job, hire_date hire
FROM employees;

SELECT job_id ||',  '|| last_name AS "Employee and Title"
FROM employees;

SELECT last_name, salary
FROM employees
WHERE salary > 12000;

SELECT last_name, department_id, job_id
FROM employees
WHERE employee_id IN ('176');

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name IN ('Matos', 'Taylor')
ORDER BY hire_date; 

SELECT last_name, department_id
FROM employees
WHERE department_id IN (20, 50)
ORDER BY last_name;

SELECT last_name || department_id Employee, salary Monthly
FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20 ,50);

select to_char(sysdate, 'YYYY"��" MM"��" DD"��" ') ��¥
from dual;

SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE '%94%';

SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- ����� �߿��� �̸��� 'le'�� ���� ����� �̸�, �޿��� ����Ͻÿ�.
SELECT last_name, salary
FROM employees
WHERE last_name LIKE '%le%';

--���� �ڵ忡 '_'�� ���� ����� �̸�, �����ڵ带 ����Ͻÿ�.
SELECT job_id, last_name
FROM employees
WHERE job_id LIKE '%\_%' escape '\';

SELECT last_name, commission_pct
FROM employees
ORDER BY 2 desc;

SELECT sysdate "date" 
FROM dual;

SELECT employee_id, last_name, ROUND(salary*1.15)
FROM employees;

SELECT employee_id, last_name, salary, ROUND(salary * 1.15, 0),
             ROUND(salary * 1.15, 0) - salary 
FROM employees;

SELECT MAX(AVG(nvl(salary,0)))
FROM employees
GROUP BY department_id;
--�μ��� ��ձ޿��� ���ϰ�, ��� �޿��� ���� ���� �μ��� ����Ͻÿ�.

SELECT salary, department_id
from employees;

SELECT job_id, case job_id WHEN 'ST_CLERK' THEN 'E'
                                      WHEN 'IT_PROG' THEN 'D'
                                      WHEN 'ST_MAN' THEN 'B'
                                      WHEN 'AD_PRES' THEN 'A'
                                      WHEN 'SA_REP' THEN 'C'
                                      ELSE '0' END GRADE                                     
FROM  employees;

--����� �߿��� �޿��� 2000�����̸� 30�ۼ�Ʈ �λ�,
--                     �޿��� 3000���ϸ� 20�ۼ�Ʈ �λ�,
--                     �޿��� 4000�����̸� 10�ۼ�Ʈ �λ�,
--                      �޿��� 5000�����̸� 5�ۼ�Ʈ �λ�,
--                       �޿��� 5000�̻��̸� �޿��λ� ����.
-- �ǵ��� ����̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.

SELECT last_name, salary, 
       CASE WHEN salary <=2000 THEN salary*1.30   
                WHEN salary <=3000 THEN salary*1.20
               WHEN salary <=4000 THEN salary*1.10
              WHEN salary <=5000 THEN salary*1.05
              ELSE salary
         END "annual"
FROM employees; 


--����̸�, �޿�, �μ��̸��� ����Ͻÿ�. (JOIN)
SELECT e.last_name, e.salary, d.department_name
FROM employees e NATURAL JOIN departments d;

SELECT e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d
         USING(department_id);
         
SELECT e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d
    ON(e. department_id=d.department_id);

--å�� ���� JOIN ����
SELECT e.last_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; 

select distinct department_id
FROM employees
ORDER BY 1;

-- 20�� �μ��� �ٹ��ϴ� ����� ����̸�, �μ���ȣ, �μ��̸��� ����Ͻÿ�.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
         ON(e.department_id = e.department_id)
WHERE e.department_id = 20;        
----
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id  = 20;
-- �� ���� ����� �� �ٸ�...?



-- IT �μ��� �ٹ��ϴ� ����� �̸�, �޿��� ����Ͻÿ�.
SELECT department_id
FROM departments
WHERE lower(department_name)='it';


SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id
FROM departments
WHERE lower(department_name)='it');