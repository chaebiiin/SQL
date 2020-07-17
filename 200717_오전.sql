--������ �Լ� 20-07-17 ����

-- �ҹ��� ��ȯ // �빮�� ��ȯ
select initcap(ename), upper(job) from emp;

-- length�� ���� ��
select ename, length(ename) from emp;

--�ѱ���  length�� ���� �� Ȯ���� �� 
select player_name, length(player_name) from player;

--�� ���ڴ� ����Ʈ �� Ȯ�� 
select player_name, lengthb(player_name) from player;

--(���ڿ�, m,n) m��ġ���� n���� ������ ���̿� �ش��ϴ� ���ڸ� ��ȯ
select ename, substr(ename, 1,3) from emp;

--�̸��� 'S'�� �����»��, %�� ���� ���
select * from emp
where substr(ename, -1,1)='S';

--ename�� 'A'�� ���� ���ڿ��� ��ġ ��ȯ
select ename, INSTR(ename , 'A') from emp;

--ename�� 'A'�� �� ���� ��� ��ȯ
select * from emp
where  INSTR(ename , 'A')  = 0;

--ename�� �������� _�� ä��, sal�� ������ *�� ä��
select rpad(ename, 15,'_'), lpad(sal, 5, '*') from emp;

-- ���ڿ� ���ļ� �����ֱ� concat ���
select concat(player_name, position)
from player;
--���� concat ���
select concat(concat(player_name,'_ '), position)
from player;
-- || ���
select player_name||'_ '|| position
from player;

--���ڿ����� �Ӹ���, ������ �Ǵ� ���ʿ� �ִ� ���� ���ڸ� �����Ѵ�. (both�� ����Ʈ)
select trim('w' from 'window'), trim(leading 'w' from 'window'), trim(trailing 'w' from 'window')
from dual;
--(both�� ����Ʈ)
select trim('0' from '000000123450000000') from dual;

-- (�Ұ���) �߶� ���ڸ� 2���� �����ϴ°� �� ��. �� �� �Ϸ��� ltrim rtrim�� ������
select trim('01' from '0101123450101') from dual;
--ltrim ���ʿ��� �߶�
select ltrim('010123450101', '01') from dual;
--rtrim �����ʿ��� �߶�
select rtrim('010123450101', '01') from dual;
-- �� �� ���ļ� ����� ��
select ltrim('010123450101', '01'), rtrim('010123450101', '01')  from dual;

--���ڳ� ���ڸ� ascii �ڵ� ��ȣ�� �ٲپ� �ش�.
select ascii('a'), ascii('��') from dual;
--ascii �ڵ尪�� ��ȣ�� ������ �װ� ���ڳ� ���ڷ� ��ȯ
select chr(100) from dual;
--(����, m) ���ڸ� �Ҽ��� m�ڸ����� �ݿø��ؼ� �����Ѵ�. m�� �����Ǹ� ����Ʈ�� 0
select round(1534827,2), round(1534827,1), round(1534827,0), round(1534827,-1), round(1534827,-2)
from dual;
--(����, m) ���ڸ�  �Ҽ� m�ڸ����� �߶󳻼� ������. ����Ʈ 0
select trunc(1534827,2), trunc(1534827,1), trunc(1534827,0), trunc(1534827,-1), trunc(1534827,-2)
from dual;

--(����1,����2) ����1�� ����2�� ������ ������ ���� ����.
select mod(1000,300) from dual;

--ceil���ڰ� "ũ�ų� ����" �ּ��� ������ �����Ѵ�. 
--floor ���ڰ� "�۰ų� ����" �ִ� ���� ����.
select ceil(153.847), floor(153.847) from dual;

--
select abs(-200), abs(200) from dual;

--������ �ŵ����� ���� ����. 
select power(2,3) from dual;

--������ ������ ���� ����(?)
select sqrt(2), sqrt(4) from dual;

--���� ���ڿ��� +10��, -10������
select sysdate+10, sysdate-10 from dual;
--���� ���ڿ��� 
select add_months(sysdate, 6), months_between(sysdate, '20/02/18'), next_day(sysdate, '��'), last_day(sysdate)
from dual;
--��¥���� �״�θ� ������ extract �� to_char�ε� ��Ÿ �� �� �ִ�.(������尡 ����)
select extract(year from sysdate), extract(month from sysdate), extract(day from sysdate)
from dual;

--���ڷ� ��ȯ�ؼ� ��õȴ�.
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;

--��,��,�� ��� ����ϱ� () 
select to_char(sysdate, 'yyyy'), to_char(sysdate, 'mm'), to_char(sysdate, 'dd') from dual;

--sal�� ���ڸ� �߰��ؼ� ��Ÿ����. 
select empno,ename, to_char(sal, '$9,999') from emp;
--����!��
select empno,ename, to_char(sal, '$999') from emp;

--to_number('����', '���� ������ Ÿ���� �Է�����')
select * from emp where sal > to_number('$1,500', '$9,999');




--CASE (if then else)

--else �� ����, else�� ���� ���ǿ� ���� �ʴ� ���� null�� ���� ��
select empno, ename,sal,job,
          case job when 'CLERK' then sal*12
                      when 'SALESMAN' then sal*1.1
                else sal end as new_sal
from emp;

--��� ������ �� �� �� �ִ�???????
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

--���� �ٿ� ���� ����� ����. decode�� �Լ��̴�.??
select empno, ename, sal,
decode(job, 'CLERK', sal*1.2, 'SALESMAN', sal *1.1) as new_sal
from emp;

--(Į�Ÿ�, ��ü�� ����or ����) null���� ��ü�ؼ� �������.
--comm�� �Ȱ��� ������ Ÿ������ �Է� ����� �Ѵ�.
select empno, ename,sal, nvl(comm, 1) from emp;

--��ü�� ���� ����Ÿ Ÿ���� ��ȯ���� �� ���
select empno, ename,sal, nvl(to_char(comm), 'NO') from emp;

-- �ΰ��� ����� �ȵ� �Ф�
select empno, ename, sal, comm, sal*1.2+comm as ����
from emp;

--!!�ذ�!!(null ���� 0���� ��ȯ�� �� ���)
select empno, ename, sal, comm, sal*1.2+nvl(comm,0) as ����
from emp;

--nvl2�� ����ؼ�
select empno, ename, sal , sal*1.2+nvl(comm, 0) as ����,
          nvl2(comm, 'Y','N') 
from emp;

--�μ����� ��������� null, �ٸ��� ù��° �μ� ���� ����
select nullif(100, 300-200), nullif(100,300-50)
from dual;

--Ŀ�̼��� ������ ?????
select empno,ename, sal, comm,
          nullif(sal*12, sal*12+nvl(comm, 0))
from emp;

--coalesce�� ���� �μ��� ���� ������ ����. �μ��߿� ó������  null�� �ƴϿ��� ���� ��� ����.
--����ȭ�� �� ���� ���̺��� ����� �ȴ�. �Ӽ��� �ݺ��Ǵ� �͵� �߿��� ó������ null�� �ƴѰ���  �����ä� �����δ�......??????? 
select empno, ename, comm, deptno, coalesce(comm, mgr, deptno)
from emp;

--�Ʒ��� ����� ���ϱ�
-- null ���
select mgr from emp
where empno=7839;
--�ƹ��͵� ������ ���� (������)
select mgr from emp
where empno =1234;

--null���� 999�� ��ȯ�ؼ� ��� ����.
select NVL(mgr, 999) from emp
where empno=7839;
--���°� null�� ���� �� ���� ����. �׷��� NVL�� ����� �� ��(?)
select NVL(mgr, 999) from emp
where empno = 1234;

--�׷��Լ��� ��� �� ��, null���� ���� ���� �ʴ´�!! ���� �ִ� �͸� ������ �ͼ� ���~
select avg(nvl(comm, 0)), avg(comm)
from emp;

--��
select max(mgr) from emp
where empno = 7839;

select nvl(max(mgr), 999) from emp
where empno = 7839;

--�� ���� ���� max�� ���� �׷��Լ��� �����ϸ� ������ null�� ����.
select max(mgr) from emp
where empno = 1234;
--������ ���� �������� �ƴ� null �̱� �x���� nvl�� ��� ��.
select nvl(max(mgr), 999) from emp
where empno = 1234;

select max(ename), min(hiredate), count(deptno)
from emp;

-- count(DISTINCT deptno) �ߺ����� ���� Į������ �ߺ� �����ϰ� ���
select count(*), count(comm),count(DISTINCT deptno)
from emp;

-- where ���ǿ� �� ���ϴ� Į���� count�� ���
select count(*), count(comm),count(DISTINCT deptno)
from emp
where sal > 1500;

--where�� ���� �����ϴ� �κ�.
select count(*), sum(sal)
from emp
where sal > 10000
group by deptno;

--�μ��� �޿��� ����� ��, �׷��� �˾ƾ� ������ ���� �� �� �ִ�?? 
--where���� �Լ��� ��� �� ���� ����.
--���õ� ������ �׷��� �����, having�� ������  ������ ��
select count(*), sum(sal)
from emp
group by deptno
having sum(sal) > 10000;

select deptno, job, count(*), sum(sal)
from emp
group by deptno, job
order by 1,2;