SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, &&col_name
FROM employees
ORDER BY &col_name;
-- & 변수를 만드는 규칙임, 이걸 치환 변수라고 부름,  && <- 셀렉트에서 2개를 쓰면 오더바이에 있는 &이 자동적으로 계산됨(?)

SELECT employee_id 사원번호, last_name 이름, salary 월급, department_id 부서번호, &&col_name
FROM employees
ORDER BY &col_name;
UNDEFINE col_name
DEFINE col_name
-- UNDEFINE이랑 &은 항상 세트로 입력해야 함. EFINE은 변수의 여부 확인을 위한 명령문이다.

--함수사용~~
SELECT  UPPER('Oracle DB'), LOWER('Oracle DB'), INITCAP('Oracle DB')
FROM dual;
-- UPPER(모두 대문자로), LOWER(모두 소문자로), INITCAP(앞 글자만 대문자로), dual ->빈칸...? 결과를 임시로 출력받을 때 
SELECT 2345*2
FROM dual;


SELECT employee_id, CONCAT(CONCAT(first_name,' '), last_name) AS Full_name
FROM employees;
-- 함수는 중첩되어서 연결 할 수 있다. CONCAT(CONCAT(내용, 내용),내용)

SELECT *
FROM employees
WHERE   SUBSTR(last_name,-1,1) ='s';
 --검색결과 추출/  WHERE (_____) LIKE 와 비슷한 기능을 가짐

SELECT *
FROM employees
WHERE last_name LIKE '%s';

SELECT employee_id, last_name, LENGTH(last_name)
FROM employees;

SELECT LENGTHB('oracle'), LENGTHB('오라클')
FROM dual;
-- 글자의 개수 파악해주는 함수 / LENGTHB->글자의 바이트 파악해서 나타내줌 

SELECT employee_id, last_name, INSTR(last_name, 'a',1,2)
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name,'a') <> 0;
--같지않다

SELECT *
FROM employees
WHERE last_name LIKE '%a%';
--포함되어 있는 문자 검색 함수

SELECT RPAD(last_name, 15, '*') AS last_name,
             LPAD(salary, 10, '*') AS salary
 FROM employees;            
-- 대치..? R은 오른쪽 L은 왼쪽  RPAD(테이블, 글자의 바이트, '대치할 문자나 기호')

SELECT TRIM('w' FROM 'window'), TRIM('e' FROM 'oracle')
FROM dual;
--지정 글자 제거/ 제거하고자 하는 글자가 있는 곳 지정도 가능함/ (LEADING은 앞쪽, TRAILING은 뒤쪽)

SELECT CONCAT('+82',TRIM(LEADING '0' FROM '01012345670'))
FROM dual;

SELECT employee_id, last_name,
            REPLACE(last_name, SUBSTR(last_name,2,2), '**')
FROM employees; 

SELECT*
FROM employees
WHERE LOWER(last_name) = 'king';

SELECT*
FROM employees
WHERE last_name = INITCAP('king');

-- \\\\\\\\\\\\\\숫자 함수\\\\\\\\\\\\\\

SELECT ROUND(45.927, 2), ROUND(45.927, 1),
             ROUND(45.927), ROUND(45.927, -1)
FROM dual;
SELECT TRUNC(45.927, 2), TRUNC(49.927, 1),
             TRUNC(45.927), TRUNC(45.927, -1)
FROM dual;

SELECT employee_id, salary, MOD(salary, 70)
FROM employees;

SELECT sysdate+10, sysdate-10 FROM dual;

SELECT employee_id, hire_date, TRUNC(sysdate-hire_date)
FROM employees;

SELECT employee_id, hire_date, 
           MONTHS_BETWEEN(sysdate,hire_date)
FROM employees;

SELECT employee_id, hire_date, 
            ROUND(MONTHS_BETWEEN(sysdate,hire_date))
FROM employees;

SELECT ADD_MONTHS(sysdate, 6)
FROM dual;         

SELECT NEXT_DAY(sysdate, 1) 쉬는날 FROM dual;
-- 날짜, 요일을 찾아주는것 일월화수목금토  순서대로 1~7까지로 나타 낼 수 있음.
SELECT LAST_DAY(sysdate) FROM dual;
-- 지금 달에서 마지막 날짜를 표기해줌

SELECT ROUND(sysdate, 'year'), ROUND(sysdate, 'month'),
            ROUND(sysdate, 'dd'), ROUND(sysdate, 'd')
FROM dual;
--ROUND(sysdate, 'year') 연초?연말?, ROUND(sysdate, 'month') 월초?월말?,
  ROUND(sysdate, 'dd') 하루의 시작 오전?오후?, ROUND(sysdate, 'd') 주초 (일요일)
            
SELECT TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'),
             TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'd')
FROM dual;

--사원 테이블로부터 근무한 개월 (MONTHS_BETWEEN)을 나타내고, 입사 후 6개월 후의 (ADD_MOUNTS) 날짜와
--입사 후 처음 도래하는 금요일(NEXT_DAY), 입사한 달의 1일(TRUNC)과 말일(LAST_DAY)을 표시하시오.
SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate,hire_date)),
             ADD_MONTHS(hire_date, 6), NEXT_DAY(hire_date, 6),
             TRUNC(hire_date, 'month'), LAST_DAY(hire_date)
 FROM employees;            
 
 SELECT sysdate FROM dual;            
-- 20/04/21  -> 2020-04-21  17:45:00 화요일 
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh24:mi:ss q' ) FROM dual;
--q는 분기를 나타냄
SELECT TO_CHAR(sysdate,'yyyy"년"mm"월"dd"일" hh24"시"mi"분"ss' ) FROM dual;
--날짜를 TO_CHAR로 문자 형태로 출력해 볼 수 있음.
