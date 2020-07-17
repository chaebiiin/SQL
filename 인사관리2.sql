SELECT employee_id, TO_CHAR(hire_date, 'yyyy/mm/dd hh24:mi:ss')
FROM employees;
--함수(TO_DATE)(데이터, '형식')

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
            TO_CHAR(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')
from dual;
SELECT last_name,
            TO_CHAR(hire_date, 'fmday month yyyy')
            AS HIREDATE
FROM employees;

SELECT employee_id, last_name, TO_CHAR(salary,'$9,999,999') AS salary
FROM employees;
-- $안에 0으로  채우면 앞에 자리수를 0으로 채워줌, 9는 자료의 금액에 맞게 채워줌, 

--TO_DATE는 WHERE에 쓰임
SELECT employee_id, last_name, TO_CHAR(salary,'$99,999') AS salary
FROM employees
WHERE salary > TO_NUMBER('8,000','9,999');
--TO_NUMBER('8,000','9,999'); 숫자로 인식시켜주는 함수

SELECT employee_id, last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01-01-1999', 'dd-mm-yyyy');

SELECT employee_id, last_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('01-01-1999', 'dd-mm-rr');
--rr(00~49, 50~99 나누워서 00~49는 앞쪽 세기를 나타내고, 50~99는 뒤쪽 세기를 나타냄)과 yy(현재세기를 나타내줌)

SELECT employee_id, last_name, NVL(manager_id, 8888)
FROM employees;
--NVL NULL 값이 있는 칼럼의 값을 다른 걸로 대치해서 나타내 줌
SELECT employee_id, last_name, NVL(TO_CHAR(manager_id), 'No Manager')
FROM employees;
DESC employees;
--숫자는 문자화가 가능, 문자는 숫자화로 불가능 

SELECT employee_id, last_name, 
             salary+salary*NVL(commission_pct,0) AS monthly_sal
FROM employees;

SELECT employee_id, last_name, 
             salary+salary*NVL(commission_pct,0) AS monthly_sal,
             NVL2(commission_pct, 'Y', 'N') AS bigo
FROM employees;
--Null값이 있는지 없는지 확인하는 함수

SELECT NULLIF(1,1), NULLIF(2,1)
from dual;
-- 두 인수가 같으면(결과가 같으면) NULL이 출력되고, 두 인수가 다르면 앞에 입력된 데이터가 출력되어서 나옴

SELECT employee_id, commission_pct, manager_id,
             COALESCE(commission_pct, manager_id, 99)
FROM employees;

-------------------------------구분구분 ^^7!!

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

--급여가 5000미만이면 20퍼센트 인상, 급여가 5000이상 10000이하이면 15퍼센트 인상, 급여가 10000초과이면 10퍼센트 인상된 결과
SELECT last_name, job_id,salary,
            CASE WHEN salary < 5000 THEN 1.2*salary
                     WHEN salary BETWEEN 5000 AND 10000 THEN 1.15*salary
                     WHEN salary >10000 THEN 1.1*salary
            END AS "Revised SALARY"
FROM employees;
--job_id가 CASE WHEN **** (***이면) THEN **** (***를해준다.) END AS ***** (출력값은 "****"로 나타낸다)

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
 
 
 --------------------5강--그룹그룹그룹그룹 함함함함수수수수!----------------
SELECT AVG(salary), SUM(salary), MIN(salary), MAX(salary)
FROM employees;
--AVG(평균), SUM(합계), MIN(최소값), MAX(최대값)

SELECT TRUNC(AVG(salary)), SUM(salary), MIN(salary), MAX(salary)
FROM employees
WHERE department_id = 80;
--TRUNC로 소수점 정리 할 수 있음, 합계와 평균은 숫자로 제한 됨, 

SELECT MIN(last_name), MAX(last_name)
FROM employees;
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;
--MIN, MAX COUNT 모든데이터 타입이 가능함

SELECT AVG(commission_pct), AVG(NVL(commission_pct,0))
FROM employees;
--커미션 받는 사람들 끼리만 평균을 매김, 커미션을 받는사람과 아닌사람 모두 포함하여 평균을 매김, 그룹함수는 NULL값을 빼고 계산, 

SELECT department_id, AVG(salary)
FROM employees;

SELECT COUNT(*),COUNT(department_id), COUNT(DISTINCT department_id)
FROM employees;
--COUNT 는 (*) <-테이블의 행수 파악, (DISTINCE(중복제거))를 넣을 수 있음.

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
-- HAVING 그룹의 결과를 제한함, WHERE는 행을 제한함,  WHERE은 항상 FROM 뒤에 와야 한다.

SELECT department_id, job_id, COUNT(*), TRUNC(AVG(salary))
FROM employees 
GROUP BY department_id, job_id
ORDER BY 1,2;

