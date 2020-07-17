select employee_id, last_name, salary, commission_pct,
          salary+ salary*commission_pct AS 월급
From EMPLOYEES;
-- AS는 별칭 적는 명령어! 생략해도됨!, 별칭은 한글도가능하다

select employee_id empno, last_name, salary AS Original_Salary, commission_pct "Comm Pct",
          salary+ salary*commission_pct AS 월급
From EMPLOYEES;
-- ""은 별칭에 대소문자포함 특수문자, 띄어쓰기가 지정 됨! 언더바(_)는 특수문자가 아니라, 띄어쓰기로 보면 됨

SELECT employee_id, hire_date, hire_date+365
FROM employees;
-- 날짜는  + -가 가능함
SELECT last_name 이름, salary "월_급", 12*salary
FROM employees;

SELECT last_name 이름, salary "월_급", 12*salary
FROM employees;

SELECT employee_id, first_name || last_name  AS "fullname"
FROM EMPLOYEES;
-- || 컬럼과 컬럼을 연결해서 결과값을 출력함 

SELECT employee_id, first_name ||' '|| last_name ||q'['s job is]' ||' '|| job_id as fullname
FROM EMPLOYEES;

SELECT employee_id, first_name ||'아'|| last_name Fullname
FROM employees;
-- ' ' 연결자 앞에 뭔가 입력하고 싶을 때 쓰임

select DISTINCT department_id
From employees;

-- DISTINCT는 중복값을 제거하고 보여줌, SELECT 뒤에 한번만 입력가능함, DISTINCT 뒤에 컬럼이 (,)로 여러번 이어지는건 가능
select DISTINCT department_id, Job_id
From employees;

DESCRIBE employees;
-- 테이블 구조를 알수 있게 해주는 명령어, DESC로 생략해서 입력 가능함,

--2강!!! ㅎㅎ
SELECT employee_id 사원번호, last_name, salary 월급, department_id 부서번호
FROM EMPLOYEES
WHERE department_id = 80;
-- 조건에 맞는 출력값 찾는 명령어  WHERE/ = <-비교연산자, 출력값은 문자(날짜)도 가능함 단 ''안의 문자는 대소문자까지 맞게 적어야함
SELECT employee_id 사원번호, last_name, salary 월급, department_id 부서번호
FROM EMPLOYEES
WHERE last_name = 'King';
SELECT employee_id 사원번호, last_name, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE hire_date = '87-06-17';

SELECT employee_id 사원번호, last_name, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE hire_date < '99/01/01';
-- >, <, >=, <>대소 비교 출력 기호
SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE last_name <> 'King';

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE department_id IN (50,80,90);
-- 'IN' =의 확장, 다중검색기능!

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE salary BETWEEN 5000 AND 10000;
-- ~와~ 사이의 값 검색
SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE hire_date BETWEEN '99/01/01' AND '99/12/31';

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE last_name LIKE '%i%';
-- "LIKE 패턴매칭/ 관련어 검색기능/   %<-기호로 범위를 설정함/  _(언더바)도 비슷한 기능을 함 (언더바가 글자 하나를 대신함)

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일, job_id
FROM EMPLOYEES
WHERE job_id LIKE 'AC\_%' ESCAPE '\';
-- 예외지정 할 때, 입력 값 뒤에\ (백슬래쉬) 입력 후 ESCAPE '\' 적어 주기  

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE hire_date LIKE '87%';

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일, job_id
FROM EMPLOYEES
WHERE commission_pct IS null;
-- null값을 출력해서 보고 싶을 때는 앞에 IS를 붙이면 됨! 다른 연산자는 올 수가 없음.

--조건이 여러개일 때는 AND, OR로 연결해서 씀!
SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE salary BETWEEN 5000 AND 10000
AND (department_id = 50
OR department_id = 60);

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE department_id NOT IN  (50,80,90);

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE salary NOT BETWEEN 5000 AND 10000;

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE last_name NOT LIKE '______';

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일, job_id
FROM EMPLOYEES
WHERE commission_pct IS NOT null
AND department_id  IS NOT null;

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일, job_id
FROM EMPLOYEES
WHERE job_id LIKE 'AD\_%' ESCAPE '\'
AND department_id NOT IN 10;

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, hire_date 입사일
FROM EMPLOYEES
WHERE salary NOT BETWEEN 5000 AND 10000
AND (department_id NOT IN 50
OR department_id NOT IN 110);


select*
FROM employees
ORDER BY hire_date DESC;
--  DESC는 내림차순으로 보기, 기본은 오름차순으로 보여 줌

SELECT employee_id 사원번호, last_name 이름, salary *12 AS ann_sal, department_id 부서번호
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id DESC, ann_sal DESC;
-- 컬럼의 포지션 넘버를 오더 바이로 적어 줄 수 도 있음!,표현식(salary *12와 같은)도 올 수 있다.

SELECT employee_id 사원번호, last_name 이름, salary *12 AS ann_sal, department_id 부서번호
FROM employees
WHERE department_id IS NOT NULL
AND salary*12 > 8000
ORDER BY department_id DESC, ann_sal DESC;

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호
FROM employees
WHERE department_id =&deptno;

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, &col_name
FROM employees
ORDER BY &col_name;




