--**************����***********
--3. having ��
--����!(where������ �׷��Լ��� ������� ����!)
select position as ������, round(avg((heigth), 2)) as ���Ű
from player 
where avg(hright) >= 180
group by posision;

--�ذ�!(having ���� ���ǿ� �����ϴ� ������ ��� ��.)
SELECT position as ������, round(avg(height), 2) as ���Ű
from player
group by position
having avg(height) >= 180;

--����!(�ڹ��� ������ �ƴ����� �ұ׷����� �׸��� �� ��� ������ ��������� ������ group by->having ������ ��Ű�°� ����.)
select team_id as ��ID, count(*) as �ο���
from player
where team_id IN('K09', 'K02')
group by team_id;

--�´� ����
select team_id as ��ID, count(*) as �ο���
from player
group by team_id
having team_id IN('K09', 'K02');

--p.211 �����Ǻ� ���Ű�� ���, �ִ�Ű�� 190 �̻��� ������ �����ִ� ������ ������ ���
--select������ ������� ���� �����Լ��� having���� �������� �����! ������!
select position as  ������, round(avg(height), 2) as ���Ű
from player
group by position
having max(height) >= 190;

--4. case (p.212)
select ename as �����, deptno as �μ���ȣ, 
          extract(month from hiredate) as �Ի��, sal as �޿�
from emp;

-- �μ��� �Ի���� �޿�
select ename as �����, deptno as �μ���ȣ,
        case month when 1 then sal end as m01, case month when 2 then sal end as m02,
         case month when 3 then sal end as m03, case month when 4 then sal end as m04,
          case month when 5 then sal end as m05, case month when 6 then sal end as m06,
           case month when 7 then sal end as m07, case month when 8 then sal end as m08,
            case month when 9 then sal end as m09, case month when 10 then sal end as m10,
             case month when 11 then sal end as m11, case month when 12 then sal end as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp);

-- �μ��� �Ի���� ��� �޿�!
select deptno as �μ���ȣ,
        avg(case month when 1 then sal end) as M01, avg(case month when 2 then sal end) as m02,
         avg(case month when 3 then sal end) as M03, avg(case month when 4 then sal end) as m04,
          avg(case month when 5 then sal end) as M05, avg(case month when 6 then sal end) as m06,
          avg(case month when 7 then sal end) as M07, avg(case month when 8 then sal end) as m08,
           avg(case month when 9 then sal end) as M09, avg(case month when 10 then sal end) as m10,
            avg(case month when 11 then sal end) as M11, avg(case month when 12 then sal end) as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp)
group by deptno
order by 1;

--decode ����Ͽ� �μ��� �Ի���� ��� �޿�
select deptno as �μ���ȣ,
        avg(decode (month, 1, sal )) as M01, avg(decode( month, 2,sal)) as m02,
         avg(decode (month, 3, sal )) as M03, avg(decode( month, 4,sal)) as m04,
         avg(decode (month, 5, sal )) as M05, avg(decode( month, 6,sal)) as m06,
         avg(decode (month, 7, sal )) as M07, avg(decode( month, 8,sal)) as m08,
        avg(decode (month, 9, sal )) as M09, avg(decode( month, 9,sal)) as m10,
        avg(decode (month, 11, sal )) as M11, avg(decode( month, 12,sal)) as m12
from (select ename, deptno, extract (month from hiredate) as month, sal from emp)
group by deptno
order by 1;


--���ļ���
--�Ʒ� �������� ������ ���̶� �����ϸ� �ȴ�????(���� ����� ������ ��)p.309
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
 
 
 --CUBE  rolleup�� ����� job�� �߰���??!!( rollup���� ����� ���� ��� ��).
 select deptno, job, count(*), sum (sal)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 --grouping sets (p.319)
 select deptno, job, count(*), sum (sal)
 from emp
 group by grouping sets(deptno, job, ())
 order by 1,2;
 
 --��ȣ�� �� �߰�
 INSERT into emp(empno, ename, deptno)
 VALUES (8000,'JAMES',30);
 
 COMMIt;
 
--�׷���� job �� ��,    
select deptno, job, count(*), sum (sal)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 -- <grouping>����ϸ� 0 ������� ������ 
 select deptno, job, count(*), sum (sal), grouping(deptno), grouping(job)
 from emp
 group by cube(deptno, job)
 order by 1,2;
 
 
 --window �Լ�
 --RANK  ������ �׻� over�� ��. order by�� ������������ ���
 select ename, sal, rank() over (order by sal desc) as sal_rank
 from emp
 where sal is not null;
 --dense ������ ������ �ϳ��� �Ǽ��� ����Ѵ�.
 select ename, sal, dense_rank() over (order by sal desc) as sal_rank
 from emp
 where sal is not null;
 
 -- partition by ~ job�� ��������鳢�� ������ �ű��.(�ұ׷� ������ ������ �ٽ� �ű�.)
 select job, ename, sal, rank() over(partition by job order by sal desc) as sal_rank
 from emp
 where sal is not null;

--ROW_NUMBER ���� ���� ���� ������ ������� ǥ�� 
select ename, sal, row_number() over(order by sal desc) as sal_rank
 from emp
 where sal is not null;

 -- ���� ������ ����� �� �̸������� �� �� ������ ��.
 select ename, sal, row_number() over(order by sal desc, ename) as sal_rank
 from emp
 where sal is not null;
 
 --3.�Ϲ� �����Լ�
 --�Ŵ����� �ΰ� �ִ� ������� �޿��� ��. partition~ �κ��� ���� �Ŵ������� �����͸� ��Ƽ��ȭ �Ѵ�.
 select mgr, ename, sal, sum(sal) over (PARTITION by mgr) as sal_sum
 from emp;
 --dept ����
 select deptno, ename,sal, sum(sal) over (PARTITION by deptno) dept_sum
 from emp;
 
 -- �޿��� ���������� ���
 select deptno, ename,sal, sum(sal) over (PARTITION by deptno order by sal
                                                          range unbounded preceding) dept_sum
from emp;

--MAX p.332
--������� �޿��� ���� �Ŵ����� �ΰ� �ִ� ������� �޿� �� �ִ밪�� �Բ� ����.
select mgr, ename, sal, max(sal) over (PARTITION by mgr) as mgr_max
from emp;
--dept ����
select  deptno, ename, sal, max(sal) over (PARTITION by deptno) as mgr_max
from emp;

-- inline view �̿�
select deptno, ename, sal
from (select deptno, ename, sal, max(sal) over (PARTITION by deptno) as max_sal
        from emp)
where sal = max_sal;

--���� �μ� �ȿ��� order by ������ �μ� �ȿ��� ��������� min(sal)
select deptno, ename, hiredate, sal, min(sal) over (PARTITION by deptno order by hiredate)
from emp;

--avg �Լ�
--rows�� ���� ���ϴ� ���ǿ� �´� �����Ϳ� ���� ��谪�� ���Ѵ�.

select deptno, ename, hiredate, sal,
          round(avg(sal) over (PARTITION by deptno order by hiredate
                              rows between 1 PRECEDING and 1 FOLLOWING)) as dept_sum
from emp;

select ename, sal, count(*) over(order by sal range between 50 PRECEDING and 150 FOLLOWING ) as sum_cnt
from emp;