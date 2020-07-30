--200729 보강~
SELECT * FROM emp;

SELECT ename 
FROM emp
WHERE lower(ename) LIKE '%j%';

--릴레이션(테이블)의 컬럼의 순서는 따로 없다. 
ALTER TABLE emp ADD (birthday DATE);

--가능하다!
SELECT ename, ename FROM emp;

--null은 알 수 없는 값, 사용할 수 없는 값, 할당 할 수 없는 값, 적용할 수 없는 값, null은 0또는 공백과 다르다.
SELECT ROUND(AVG(NVL(comm,0))) FROM emp;

--큰따옴표(" ")를 쓰는 경우는 있는그대로를 표현하기 위해 쓴다. 칼럼별칭에서 ex) as "test"
--형식포맷을 쓸 때 (" ")를 쓴다. 
SELECT TO_CHAR(hiredate, 'yyyy"년", mm"월", DD"일"')
FROM emp;

--연결연산자(||)
--연결 함수 CONCAT
SELECT CONCAT(ename, sal) 
FROM emp;

--DISTINCT(중복값 제거), DISTINCT는 한번만 선언 가능
SELECT DISTINCT deptno, job 
FROM emp;

--ALL 은 디폴트 값
SELECT all deptno 
FROM emp;

/*WHERE 절( WHERE+ 비교대상 칼럼 + 비교 연산자 + 인수) 
하나의 row는 튜플 / 튜플의 모임은 카디널리티???   단일행함수는 쓸 수 있다. (단일행 함수는 각 함수의 제어를 함)
그룹 함수는 쓸 수 없다? */

--논리적 오류가 난다.  무조건 앞 숫자가 작아야 한다!? 
SELECT ename, sal
 FROM emp
 WHERE sal BETWEEN 1500 AND 1000;

--문자 비교도 가능하다!
SELECT ename, sal
 FROM emp
WHERE ename BETWEEN 'A' AND 'F';

SELECT player_name
FROM player
WHERE player_name BETWEEN '김' AND '한';

SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL;


