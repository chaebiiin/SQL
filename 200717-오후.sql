--**************복습***********
--3. having 절
--오류!(where절에서 그룹함수는 허용하지 않음!)
select position as 포지션, round(avg((heigth), 2)) as 평균키
from player 
where avg(hright) >= 180
group by posision;

--해결!(having 절에 조건에 만족하는 내용이 출력 됨.)
SELECT position as 포지션, round(avg(height), 2) as 평균키
from player
group by position
having avg(height) >= 180;

--오류!(★문법 에러는 아니지만 소그룹으로 그립핑 돼 통계 정보가 만들어지기 때문에 group by->having 순서를 지키는게 좋다.)
select team_id as 팀ID, count(*) as 인원수
from player
where team_id IN('K09', 'K02')
group by team_id;

--맞는 문법
select team_id as 팀ID, count(*) as 인원수
from player
group by team_id
having team_id IN('K09', 'K02');

--p.211 포지션별 평균키를 출력, 최대키가 190 이상인 선수가 갖고있는 포지션 정보만 출력
--select절에서 사용하지 않은 집계함수를 having에서 조건절로 사용함! 가능함!
select position as  포지션, round(avg(height), 2) as 평균키
from player
group by position
having max(height) >= 190;

--4. case (p.212)
select ename as 사원명, deptno as 부서번호, 
          extract(month from hiredate) as 입사월, sal as 급여
from emp;

-- 부서별 입사월별 급여
select ename as 사원명, deptno as 부서번호,
        case month when 1 then sal end as m01, case month when 2 then sal end as m02,
         case month when 3 then sal end as m03, case month when 4 then sal end as m04,
          case month when 5 then sal end as m05, case month when 6 then sal end as m06,
           case month when 7 then sal end as m07, case month when 8 then sal end as m08,
            case month when 9 then sal end as m09, case month when 10 then sal end as m10,
             case month when 11 then sal end as m11, case month when 12 then sal end as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp);

-- 부서별 입사월별 평균 급여!
select deptno as 부서번호,
        avg(case month when 1 then sal end) as M01, avg(case month when 2 then sal end) as m02,
         avg(case month when 3 then sal end) as M03, avg(case month when 4 then sal end) as m04,
          avg(case month when 5 then sal end) as M05, avg(case month when 6 then sal end) as m06,
          avg(case month when 7 then sal end) as M07, avg(case month when 8 then sal end) as m08,
           avg(case month when 9 then sal end) as M09, avg(case month when 10 then sal end) as m10,
            avg(case month when 11 then sal end) as M11, avg(case month when 12 then sal end) as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp)
group by deptno
order by 1;

--decode 사용하여 부서별 입사월별 평균 급여
select deptno as 부서번호,
        avg(decode (month, 1, sal )) as M01, avg(decode( month, 2,sal)) as m02,
         avg(decode (month, 3, sal )) as M03, avg(decode( month, 4,sal)) as m04,
         avg(decode (month, 5, sal )) as M05, avg(decode( month, 6,sal)) as m06,
         avg(decode (month, 7, sal )) as M07, avg(decode( month, 8,sal)) as m08,
        avg(decode (month, 9, sal )) as M09, avg(decode( month, 9,sal)) as m10,
        avg(decode (month, 11, sal )) as M11, avg(decode( month, 12,sal)) as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp)
group by deptno
order by 1;


--오후수업
--아래 쿼리문의 합집합 격이라 생각하면 된다????(수업 제대로 못들음 ㅠ)p.309
--ROLLUP 
 select deptno, job, count(*), sum (sal)
 from emp
 group by rollup(deptno, job)
 order by 1,2;
 
 --
 select deptno, job, count(*), sum (sal)
 from emp
 group by deptno, job
 UNION
 select deptno, to_char(null), count(*), sum (sal)
 from emp
 group by deptno
 UNION
 select to_number(null),to_char(null),count(*), sum(sal)
 from emp
 order by 1,2;
 
 
 --CUBE  rolleup의 결과에 job이 추가됨??!!( rollup보다 결과가 많이 출력 됨).
 select deptno, job, count(*), sum (sal)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 --grouping sets (p.319)
 select deptno, job, count(*), sum (sal)
 from emp
 group by grouping sets(deptno, job, ())
 order by 1,2;
 
 --모호한 행 추가
 INSERT into emp(empno, ename, deptno)
 VALUES (8000,'JAMES',30);
 
 COMMIt;
 
--그룹바이 job 할 때,    
select deptno, job, count(*), sum (sal)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 -- <grouping>사용하면 0 사용하지 않으면 
 select deptno, job, count(*), sum (sal), grouping(deptno), grouping(job)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 
 --window 함수
 --RANK  문법상 항상 over가 옴. order by로 내림차순으로 출력
 select ename, sal, rank() over (order by sal desc) as sal_rank
 from emp
 where sal is not null;
 --dense 동일한 순위를 하나의 건수로 취급한다.
 select ename, sal, dense_rank() over (order by sal desc) as sal_rank
 from emp
 where sal is not null;
 
 -- partition by ~ job이 같은사람들끼리 등위를 매긴다.(소그룹 내에서 순위를 다시 매김.)
 select job, ename, sal, rank() over(partition by job order by sal desc) as sal_rank
 from emp
 where sal is not null;

--ROW_NUMBER 동일 순위 없이 순위를 순서대로 표현 
select ename, sal, row_number() over(order by sal desc) as sal_rank
 from emp
 where sal is not null;

 -- 같은 순위의 사람들 중 이름순으로 더 윗 순위가 됨.
 select ename, sal, row_number() over(order by sal desc, ename) as sal_rank
 from emp
 where sal is not null;
 
 --3.일반 집계함수
 --매니저를 두고 있는 사원들의 급여의 함. partition~ 부분을 통해 매니저별로 데이터를 파티션화 한다.
 select mgr, ename, sal, sum(sal) over (PARTITION by mgr) as sal_sum
 from emp;
 --dept 기준
 select deptno, ename,sal, sum(sal) over (PARTITION by deptno) dept_sum
 from emp;
 
 -- 급여의 누적데이터 출력
 select deptno, ename,sal, sum(sal) over (PARTITION by deptno order by sal
                                                          range unbounded preceding) dept_sum
from emp;

--MAX p.332
--사원들의 급여와 같은 매니저를 두고 있는 사람들의 급여 중 최대값을 함께 구함.
select mgr, ename, sal, max(sal) over (PARTITION by mgr) as mgr_max
from emp;
--dept 기준
select  deptno, ename, sal, max(sal) over (PARTITION by deptno) as mgr_max
from emp;

-- inline view 이용
select deptno, ename, sal
from (select deptno, ename, sal, max(sal) over (PARTITION by deptno) as max_sal
        from emp)
where sal = max_sal;

--동일 부서 안에서 order by 동일한 부서 안에서 현재까지의 min(sal)
select deptno, ename, hiredate, sal, min(sal) over (PARTITION by deptno order by hiredate)
from emp;

--avg 함수
--rows를 통해 원하는 조건에 맞는 데이터에 대한 통계값을 구한다.

select deptno, ename, hiredate, sal,
          round(avg(sal) over (PARTITION by deptno order by hiredate
                              rows between 1 PRECEDING and 1 FOLLOWING)) as dept_sum
from emp;

select ename, sal, count(*) over(order by sal range between 50 PRECEDING and 150 FOLLOWING ) as sum_cnt
from emp;