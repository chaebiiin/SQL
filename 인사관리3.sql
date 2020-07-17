SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;
--JOIN�� �� ���� ���̺�(�����̼�)�� ��� ������� ����� ��,
--NATURAL ���� ���̺��� �̸��� ���ƾ� ��.

SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
-- ���� �� ���̺��� �������̰� ���̺��� �̸��� ���ƾ� �� �� ����.

SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
-- ���ο� �� ��, ON�� �Ἥ ���� �� ���̺��� ��ü������ ������������

SELECT e.employee_id, e.last_name, e.department_id, 
              d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
-- �� �Ҹ��� ��;;

SELECT e.employee_id, e.last_name, d.department_name,
             l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);


-----7��

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT salary
                        FROM employees
                         WHERE last_name =  'Abel');
 -- ()�� �Ἥ ���������� ���� ����, �����ȣ, �̸�. ������ ��� ���̺��� ã�� (������ '�ƺ�'���� ���� �޴� ���� ã��)
 
 SELECT employee_id, last_name, salary
 FROM employees
 WHERE salary IN (SELECT MIN(salary)
                        FROM employees
                        GROUP BY department_id); 
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id
                        FROM employees
                        WHERE last_name = 'Taylor')
AND salary > (SELECT salary
                  FROM employees
                  WHERE last_name = 'Taylor');
                  
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id;

SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                        FROM employees
                        WHERE last_name = 'King');
                        
                        
SELECT employee_id, last_name, job_id, salary
From employees
WHERE salary > ANY 
                      (SELECT salary
                      FROM employees
                      WHERE job_id = 'IT_PROG');
                      
SELECT employee_id, last_name, manager_id, salary
FROM employees
WHERE employee_id NOT IN (SELECT manager_id   
                                 FROM employees
                                 WHERE manager_id IS NOT NULL);
 DESC employees                                
 
 
 
 ---------------8�� ����---------
 SELECT *
 FROM job_history;
 
SELECT employee_id FROM employees
 INTERSECT
SELECT employee_id FROM job_history;
 
SELECT employee_id, job_id FROM employees
INTERSECT
SELECT employee_id, job_id FROM job_history;
 
 
SELECT employee_id FROM employees
 UNION
 SELECT employee_id FROM job_history;
 
SELECT employee_id, job_id FROM employees
 UNION
 SELECT employee_id, job_id FROM job_history;