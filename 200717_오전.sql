--문자형 함수 20-07-17 오전

-- 소문자 변환 // 대문자 변환
select initcap(ename), upper(job) from emp;

-- length는 글자 수
select ename, length(ename) from emp;

--한글을  length로 글자 수 확인해 봄 
select player_name, length(player_name) from player;

--한 문자당 바이트 수 확인 
select player_name, lengthb(player_name) from player;

--(문자열, m,n) m위치에서 n개의 문자의 길이에 해당하는 문자를 반환
select ename, substr(ename, 1,3) from emp;

--이름인 'S'로 끝나는사람, %와 같은 기능
select * from emp
where substr(ename, -1,1)='S';

--ename에 'A'가 들어가는 문자열의 위치 반환
select ename, INSTR(ename , 'A') from emp;

--ename에 'A'가 안 들어가는 사람 반환
select * from emp
where  INSTR(ename , 'A')  = 0;

--ename의 오른쪽을 _로 채움, sal의 왼쪽을 *로 채움
select rpad(ename, 15,'_'), lpad(sal, 5, '*') from emp;

-- 문자열 합쳐서 보여주기 concat 사용
select concat(player_name, position)
from player;
--이중 concat 사용
select concat(concat(player_name,'_ '), position)
from player;
-- || 사용
select player_name||'_ '|| position
from player;

--문자열에서 머리말, 꼬리말 또는 양쪽에 있는 지정 문자를 제거한다. (both가 디폴트)
select trim('w' from 'window'), trim(leading 'w' from 'window'), trim(trailing 'w' from 'window')
from dual;
--(both가 디폴트)
select trim('0' from '000000123450000000') from dual;

-- (불가능) 잘라낼 문자를 2개로 지정하는건 안 됨. 이 걸 하려고 ltrim rtrim이 있음ㅋ
select trim('01' from '0101123450101') from dual;
--ltrim 왼쪽에서 잘라냄
select ltrim('010123450101', '01') from dual;
--rtrim 오른쪽에서 잘라냄
select rtrim('010123450101', '01') from dual;
-- 둘 다 합쳐서 출력해 봄
select ltrim('010123450101', '01'), rtrim('010123450101', '01')  from dual;

--문자나 숫자를 ascii 코드 번호로 바꾸어 준다.
select ascii('a'), ascii('아') from dual;
--ascii 코드값을 번호를 넣으면 그걸 문자나 숫자로 변환
select chr(100) from dual;
--(숫자, m) 숫자를 소수점 m자리에서 반올림해서 리턴한다. m이 생략되면 디폴트는 0
select round(1534827,2), round(1534827,1), round(1534827,0), round(1534827,-1), round(1534827,-2)
from dual;
--(숫자, m) 숫자를  소수 m자리에서 잘라내서 버린다. 디폴트 0
select trunc(1534827,2), trunc(1534827,1), trunc(1534827,0), trunc(1534827,-1), trunc(1534827,-2)
from dual;

--(숫자1,숫자2) 숫자1을 숫자2로 나누어 나머지 값을 리턴.
select mod(1000,300) from dual;

--ceil숫자가 "크거나 같은" 최소의 정수를 리턴한다. 
--floor 숫자가 "작거나 같은" 최대 정수 리턴.
select ceil(153.847), floor(153.847) from dual;

--
select abs(-200), abs(200) from dual;

--숫자의 거듭제곱 값을 리턴. 
select power(2,3) from dual;

--숫자의 제곱근 값을 리턴(?)
select sqrt(2), sqrt(4) from dual;

--현재 날자에서 +10일, -10일해줌
select sysdate+10, sysdate-10 from dual;
--현재 날자에서 
select add_months(sysdate, 6), months_between(sysdate, '20/02/18'), next_day(sysdate, '월'), last_day(sysdate)
from dual;
--날짜형식 그대로를 가져씀 extract 는 to_char로도 나타 낼 수 있다.(오버헤드가 없다)
select extract(year from sysdate), extract(month from sysdate), extract(day from sysdate)
from dual;

--글자로 변환해서 출련된다.
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;

--년,월,일 끊어서 출력하기 () 
select to_char(sysdate, 'yyyy'), to_char(sysdate, 'mm'), to_char(sysdate, 'dd') from dual;

--sal을 문자를 추가해서 나타내줌. 
select empno,ename, to_char(sal, '$9,999') from emp;
--오류!ㅋ
select empno,ename, to_char(sal, '$999') from emp;

--to_number('숫자', '앞의 숫자의 타입을 입력해줌')
select * from emp where sal > to_number('$1,500', '$9,999');




--CASE (if then else)

--else 는 선택, else를 빼면 조건에 맞지 않는 행은 null이 나옴 ☆
select empno, ename,sal,job,
          case job when 'CLERK' then sal*12
                      when 'SALESMAN' then sal*1.1
                else sal end as new_sal
from emp;

--모든 조건을 다 볼 수 있다???????
select empno, ename,sal,
          case when job = 'CLERK' then sal*12
                      when  job = 'SALESMAN' then sal*1.1
                else sal end as new_sal
from emp;

--??
select empno, ename, sal,
case when sal < 1000 then 'C'
when sal between 1000 and 1700 then 'B'
else 'A' end as sal_grade
from emp;

--위의 ☆와 같은 결과가 나옴. decode는 함수이다.??
select empno, ename, sal,
decode(job, 'CLERK', sal*1.2, 'SALESMAN', sal *1.1) as new_sal
from emp;

--(칼렴명, 대체할 숫자or 문자) null값을 대체해서 출력해줌.
--comm과 똑같은 데이터 타입으로 입력 해줘야 한다.
select empno, ename,sal, nvl(comm, 1) from emp;

--대체할 곳에 데이타 타입을 변환해준 뒤 출력
select empno, ename,sal, nvl(to_char(comm), 'NO') from emp;

-- 널값은 계산이 안됨 ㅠㅠ
select empno, ename, sal, comm, sal*1.2+comm as 연봉
from emp;

--!!해결!!(null 값을 0으로 변환한 뒤 계산)
select empno, ename, sal, comm, sal*1.2+nvl(comm,0) as 연봉
from emp;

--nvl2를 사용해서
select empno, ename, sal , sal*1.2+nvl(comm, 0) as 연봉,
          nvl2(comm, 'Y','N') 
from emp;

--인수에서 결과같으면 null, 다르면 첫번째 인수 값을 리턴
select nullif(100, 300-200), nullif(100,300-50)
from dual;

--커미션을 받으면 ?????
select empno,ename, sal, comm,
          nullif(sal*12, sal*12+nvl(comm, 0))
from emp;

--coalesce는 들어가는 인수의 개수 제한이 없다. 인수중에 처음으로  null이 아니였던 값을 출력 해줌.
--정규화를 잘 못한 테이블에서 사용이 된다. 속성이 반복되는 것들 중에서 처음으로 null이 아닌것을  가져올ㄸ ㅐ쓰인다......??????? 
select empno, ename, comm, deptno, coalesce(comm, mgr, deptno)
from emp;

--아래의 문장과 비교하기
-- null 출력
select mgr from emp
where empno=7839;
--아무것도 나오지 않음 (공집합)
select mgr from emp
where empno =1234;

--null값을 999로 변환해서 출력 해줌.
select NVL(mgr, 999) from emp
where empno=7839;
--없는게 null과 같아 질 수는 없다. 그래서 NVL이 사용이 안 됨(?)
select NVL(mgr, 999) from emp
where empno = 1234;

--그룹함수는 계산 할 때, null값을 포함 하지 않는다!! 값이 있는 것만 가지고 와서 계산~
select avg(nvl(comm, 0)), avg(comm)
from emp;

--▼
select max(mgr) from emp
where empno = 7839;

select nvl(max(mgr), 999) from emp
where empno = 7839;

--▼ 없는 값에 max와 같은 그룹함수를 적용하면 공란에 null이 들어간다.
select max(mgr) from emp
where empno = 1234;
--▼위와 같이 공집합이 아닌 null 이기 땨문에 nvl이 사용 됨.
select nvl(max(mgr), 999) from emp
where empno = 1234;

select max(ename), min(hiredate), count(deptno)
from emp;

-- count(DISTINCT deptno) 중복도가 높은 칼럼에서 중복 제거하고 출력
select count(*), count(comm),count(DISTINCT deptno)
from emp;

-- where 조건에 만 족하는 칼럼의 count를 출력
select count(*), count(comm),count(DISTINCT deptno)
from emp
where sal > 1500;

--where은 행을 선택하는 부분.
select count(*), sum(sal)
from emp
where sal > 10000
group by deptno;

--부서별 급여를 출력할 때, 그룹을 알아야 조건을 지정 할 수 있다?? 
--where에는 함수가 들어 갈 수가 없다.
--선택된 행으로 그룹을 만들고, having을 가지고  조건을 줌
select count(*), sum(sal)
from emp
group by deptno
having sum(sal) > 10000;

select deptno, job, count(*), sum(sal)
from emp
group by deptno, job
order by 1,2;