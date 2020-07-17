(i1 INTERVAL year to month,
i2 INTERVAL day to second);

INSERT INTO service
VALUES(INTERVAL '3-5' year to month, INTERVAL '90 12:30:00' day to second);
--3년하고 5개월 // 90일 12시30분00초
COMMIT;

SELECT * FROM service;
--예전 방식...
SELECT id,ord_d1 주문날짜, ADD_MONTHS(ord_d1, 41) "서비스 종료일"
FROM orders;
-- 주문날짜에서 3년 5개월 더 한 값, 주문날짜에서 90일, 12시30분 00초 더한 값
SELECT id, ord_d2 주문날짜, ord_d1+i1 서비스종료일, ord_d1+i2 "제품등록 만료일"
FROM orders, service;

SELECT employee_id, last_name, hire_date 입사일, hire_date+i1 "입사 후 3년 5개월 후"
FROM employees, service;
DESC service;




--사원들이 입사한 월 조회
SELECT employee_id, last_name, TO_CHAR(hire_date, 'mm') "입사 월 "
FROM employees;
--EXTRACT를 사용해서 사원들의 입사한 월 조회
SELECT employee_id, last_name, EXTRACT(month FROM hire_date)
FROM employees;

SELECT TZ_OFFSET('Asia/Seoul') FROM dual;

DROP TABLE emp purge;

CREATE TABLE emp
AS
SELECT employee_id, last_name, salary, hire_date
FROM employees;
SELECT * FROM emp;

--emp테이블의 데이터 타입을 바꿔서 나타내줌
ALTER TABLE myemp
MODIFY hire_date timestamp;

--query 하는 동안에만 데이터 타입을 바꿔서 보여줌?
SELECT employee_id, last_name, FROM_TZ(hire_date, 'Asia/Seoul')
FROM emp;
SELECT employee_id, last_name, FROM_TZ(hire_date, '+9:00')
FROM emp;

--TO_YMINTERVAL을 이용
SELECT hire_date, hire_date + to_YMINTERVAL('01-02') "1년 2개월 후"
FROM employees
WHERE department_id = 20;

--TO_DSINTERVAL을 이용
ALTER TABLE employees
MODIFY hire_date timestamp;
SELECT last_name,hire_date, hire_date+TO_DSINTERVAL('100 10:00:00') "100일 10시간 뒤"
FROM employees;

--Abel의 월급보다 많이 받는 사람 찾기
SELECT * FROM employees
WHERE salary >(SELECT salary FROM employees
                      WHERE last_name = 'Abel');

--emp                     
@C:\oraclexe\labs\cre_empl.sql

-- sql책 6-5 실습
SELECT* FROM empl_demo;
--존들의 부서번호와 매니저 번호가 같은 사람 찾기
SELECT employee_id, manager_id, department_id, last_name FROM empl_demo
WHERE first_name = 'John';
-- 쌍으로(매니저 번호와 부서번호가 같은거) 비교함
--자기 자신은 제외하려고 AND ~ 이 구절을 넣음. 
SELECT employee_id, manager_id, department_id, last_name
FROM empl_demo
WHERE(manager_id, department_id) IN
                              (SELECT manager_id, department_id
                              FROM empl_demo
                              WHERE first_name = 'John')
AND first_name <> 'John';

-- sql 책 6-6 실습
-- 매니저 번호 같은거 따로 부서번호 같은거 따로 해서 찾음
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
-- sql 책 6-11 실습
-- 현재 부서번호와 외부테이블에 있는 부서번호를 보고, 
--부서의 평균급여와 부서사원들 간의 월급 비교해서 조건에 맞는(평균급여보다 더 큰 애만 출력) 값만 출력
SELECT last_name, salary, department_id
FROM employees o -- ◁외부테이블
WHERE salary > ( SELECT AVG(salary) FROM employees i
                        WHERE i.department_id = o.department_id);

SELECT last_name, salary, department_id
FROM employees
WHERE salary > ANY (SELECT AVG(salary) FROM employees
                      GROUP BY department_id);
                      
--부서별 평균 급여
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id;

--소속부서의 평균급여보다 더 많이 받는 사원 출력하기
SELECT a.employee_id, a.last_name, a.salary, a.department_id, b.avgsal
FROM employees a JOIN (SELECT department_id, AVG(salary) avgsal FROM employees
                                  GROUP BY department_id) b
                                  ON(a.department_id = b.department_id)
WHERE a. salary > b.avgsal;
-- sql 6-15 실습
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
--테이블 만든 후 칼럼 추가
CREATE TABLE emp6
as
SELECT employee_id, last_name, department_id
FROM employees;

ALTER TABLE emp6
ADD POSITION VARCHAR2(10);

SELECT * FROM emp6;

--추가 된 칼럼에 사원들 본인의 job_id를 입력해서 업데이트 해주기 (상호관련 업데이트...) sql 책 6-18 실습
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

--수업 시작하기 전, sql 1의 3단원 (단일행 함수)
--SUBSTR
--INSTR
--REPLACE
-- 2단원의 LIKE 연산자 
--위의 내용 예문 실행 해보기....