SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

SELECT employee_id, job_id FROM EMPLOYEES
UNION
SELECT employee_id, job_id FROM job_history;
// 집합을 하면 첫 번째 칼럼을 기준으로 정렬을 함, 두 번째 칼럼으로 정렬 해고 싶으면 ORDER BY 2(두번째 칼럼이름 넣기); 를 넣어준다.

SELECT employee_id empno, job_id  FROM employees
UNION
SELECT employee_id, job_id job_title FROM job_history;
//별칭 지정도 첫 번째 칼럼을 기준으로 첫번째 칼럼만 별칭이 출력됨
// UNION ALL은 정렬하지 않음.

SELECT employee_id, department_id FROM employees
UNION ALL
SELECT employee_id, department_id FROM job_history
ORDER BY 1,2;

SELECT employee_id, department_id, job_id FROM employees
UNION ALL
SELECT employee_id, department_id, job_id FROM job_history
ORDER BY 1,2;

--집합연산과 서브커리를 활용해서 입사 후 부서나, 업무 이동 이력이 없는 직원의 사번, 이름, 급여를 출력하시오.

SELECT employee_id, last_name, salary
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees
                              MINUS
                            SELECT employee_id FROM JOB_history);

--업무 이동이 없는 사원 구하기
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM JOB_hidtory;

-- 집합연산의 가이드 라인
--UNION ALL을 제외하고 모두 첫번째 열을 기준으로 결과가 정렬, 결과의 컬럼헤딩은 첫번째 문장의 열 이름, 별칭을 사용한다.
--각 SELECT 문의 열의 갯수, 대응되는 열의 데이터 유형이 동일해야 실행이 가능
--MINUS를 제외하고 모두 교환법칙, 결합법칙 등이 성립

--SELECT employee_id, hire_date FROM employees
--UNION
--SELECT department_id, department_name FROM departments;
-- 데이터 타입이 맞이 않을 때 맞추는 법
SELECT employee_id, hire_date, TO_CHAR(null) AS department_name FROM employees
UNION
SELECT department_id, TO_DATE(null), department_name FROM departments;

--전체사원의 총 급여, 부서별 총 급여, 부서별, 직급별 총 급여
SELECT department_id, job_id, SUM(salary) FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), SUM(salary) FROM employees  --부서별 총급여
GROUP BY department_id 
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), SUM(salary) FROM employees;





