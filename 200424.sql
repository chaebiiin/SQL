SELECT *
FROM departments;

DESC departments 

SELECT employee_id 사원번호, last_name 이름, job_id 부서코드, hire_date 입사일
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

select to_char(sysdate, 'YYYY"년" MM"월" DD"일" ') 날짜
from dual;

SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE '%94%';

SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 사원들 중에서 이름에 'le'가 들어가는 사원의 이름, 급여를 출력하시오.
SELECT last_name, salary
FROM employees
WHERE last_name LIKE '%le%';

--직업 코드에 '_'가 들어가는 사원의 이름, 직업코드를 출력하시오.
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
--부서별 평균급여를 구하고, 평균 급여가 가장 높은 부서를 출력하시오.

SELECT salary, department_id
from employees;

SELECT job_id, case job_id WHEN 'ST_CLERK' THEN 'E'
                                      WHEN 'IT_PROG' THEN 'D'
                                      WHEN 'ST_MAN' THEN 'B'
                                      WHEN 'AD_PRES' THEN 'A'
                                      WHEN 'SA_REP' THEN 'C'
                                      ELSE '0' END GRADE                                     
FROM  employees;

--사원들 중에서 급여가 2000이하이면 30퍼센트 인상,
--                     급여가 3000이하면 20퍼센트 인상,
--                     급여가 4000이하이면 10퍼센트 인상,
--                      급여가 5000이하이면 5퍼센트 인상,
--                       급여가 5000이상이면 급여인상 없음.
-- 되도록 사원이름, 급여, 인상된 급여를 출력하시오.

SELECT last_name, salary, 
       CASE WHEN salary <=2000 THEN salary*1.30   
                WHEN salary <=3000 THEN salary*1.20
               WHEN salary <=4000 THEN salary*1.10
              WHEN salary <=5000 THEN salary*1.05
              ELSE salary
         END "annual"
FROM employees; 


--사원이름, 급여, 부서이름을 출력하시오. (JOIN)
SELECT e.last_name, e.salary, d.department_name
FROM employees e NATURAL JOIN departments d;

SELECT e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d
         USING(department_id);
         
SELECT e.last_name, e.salary, d.department_name
FROM employees e JOIN departments d
    ON(e. department_id=d.department_id);

--책에 없는 JOIN 구문
SELECT e.last_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; 

select distinct department_id
FROM employees
ORDER BY 1;

-- 20번 부서에 근무하는 사원의 사원이름, 부서번호, 부서이름을 출력하시오.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
         ON(e.department_id = e.department_id)
WHERE e.department_id = 20;        
----
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id  = 20;
-- 두 개의 결과가 왜 다름...?



-- IT 부서에 근무하는 사원의 이름, 급여를 출력하시오.
SELECT department_id
FROM departments
WHERE lower(department_name)='it';


SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id
FROM departments
WHERE lower(department_name)='it');