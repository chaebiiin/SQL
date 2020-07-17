SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;
--JOIN은 두 가지 테이블(릴레이션)을 묶어서 결과물을 출력해 줌,
--NATURAL 양쪽 테이블의 이름이 같아야 함.

SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
-- 조인 할 테이블이 여러개이고 테이블의 이름이 같아야 쓸 수 있음.

SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
-- 조인에 쓸 때, ON을 써서 조인 할 테이블을 구체적으로 정의해줘햐함

SELECT e.employee_id, e.last_name, e.department_id, 
              d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
-- 뭔 소린지 모름;;

SELECT e.employee_id, e.last_name, d.department_name,
             l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);


-----7장

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT salary
                        FROM employees
                         WHERE last_name =  'Abel');
 -- ()을 써서 서브쿼리를 지정 해줌, 사원번호, 이름. 월급을 사원 테이블에서 찾고 (월급이 '아벨'보다 많이 받는 직원 찾기)
 
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
 
 
 
 ---------------8강 집합---------
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