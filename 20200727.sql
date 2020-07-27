--����1 ���̺� ������ ���� ���̺��� �����ϴ� sql���� �ۼ��Ͻÿ�.

create table depart(
        deptid number(10) primary key,
        deptname varchar2(10),
        location varchar2(10),
        tel varchar2(15));
desc depart;

--����3 ��ȸ�� ����� ���� �����͸� �Է��ϴ� sql��
insert into depart values(1001, '�ѹ���', '��101ȣ', '053-777-8777');
insert into depart values(1002, 'ȸ����', '��102ȣ', '053-888-9999');
insert into depart values(1003, '������', '��103ȣ', '053-222-333');

select * from depart;

--����1 ���̺� ������ ���� ���̺��� �����ϴ� sql���� �ۼ��Ͻÿ�. 

create table employ(
        empid number(10) primary key,
        empname varchar2(10),
        hiredate date,
        addr varchar2(12),
        tel varchar2(15),
        deptid number(10), foreign key(deptid) references depart(deptid));
desc employ;     

--�� �� �����ϴ� �� �˾ƺ���        
--alter table employ
--  add CONSTRAINT deptid_fk foreign key(deptid) references (depart);


--����3 ��ȸ�� ����� ���� �����͸� �Է��ϴ� sql��
insert into employ values(20121945, '�ڹμ�', '20120302', '�뱸','010-777-8777', 1001);
insert into employ values(20101817, '���ؽ�', '20100901', '���','010-888-9999',1003);
insert into employ values(20122245, '���ƶ�', '20120302','�뱸', '010-2222-3333', 1002);
insert into employ values(20121729, '�̹���', '20110302','����', '010-3333-4444', 1001);
insert into employ values(20121646, '������', '20120911','�λ�', '010-1234-2223', 1003);
select * from employ;

--����2 ����(employ) ���̺� ������� Į���� �߰��ϴ� sql�� �ۼ� (���� �� �� ���� �𸣰���.)
alter table employ add (birthday date);

--����4 �������̺�(employ)�� ������(empname) Į���� not null ���������� �߰��Ͻÿ�.
alter table employ modify (empname not null); 

--����5. �ѹ����� �ٹ��ϴ� ������ �̸�, �Ի���, �μ����� ����Ͻÿ�.
--���� ������ ����. ���� ������ �־������  (��� �ؾ����� ��)
select e.empname, e.hiredate, d.deptname
from employ e, depart d
where e.deptid = d.deptid
and (select deptname from depart where deptname IN '�ѹ���');

--����6 ���� ���̺��� "�뱸"���� ��� �ִ� ������ ��� �����Ͻÿ�. (�ذ�)
delete from employ
where addr = '�뱸';

--����7 ���� ���̺��� "������"�� �ٹ��ϴ� ������ ��� "ȸ��������" �����ϴ� sql���� �ۼ��ϼ���. (�ذ�)
update employ 
set  deptid = (select deptid from depart where deptname= 'ȸ����')
where deptid = (select deptid from depart where deptname = '������');

--����8 ���� ���̺��� ������ȣ�� "20121729"�� ������ �Ի��Ϻ��� �ʰ� �Ի��� ������ 
--������ȣ, �̸�, �������, �μ��̸��� ����ϴ� sql�� (deptname�� �� �� �������� �� �𸣰���.)
select e.empid, e.empname, e.birthday, d.deptname, e.hiredate
from employ e, depart d
where hiredate > (select hiredate from employ where empid = '20121729');


--����9 �ѹ����� �ٹ��ϴ� ������ �̸�, �ּ�, �μ����� �� �� �ִ� �並 �����Ͻÿ�. (�� �𸣰���.) (���� ������ �־����)
create view view_deptname
as
select e.empname, e.addr, d.deptname
from employ e, depart d
where d.deptname in '�ѹ���';






--���� ����
select e.employee_id,e.last_name, d.department_name from  departments d, employees e
where  e.department_id = d.department_id
and e.salary > (select salary from employees where employee_id = 176);

-- �μ��̸��� it�� ���� �μ��� ��� �޿�, ��� �̸� ��� 
SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id
FROM departments
WHERE lower(department_name)='it');

-- ����� �߿��� 's'�� ���� ����� �̸�, �μ����� ����Ͻÿ�. ��, 'Steven' ����� �ִ� �μ��� ����,
-- �� 's'�� �ҹ��� �Ǵ� �빮�� �� �� �ִ�.

select first_name, department_name
from employees where lower(first_name) like '%s%'
and department_id != (
select department_id
from EMPLOYEES
where lower(first_name) like 'steven');

desc employees;
desc departments;

create view view_emp_dept
as
select e.department_id, d.department_name, e.employee_id
from employees e, departments d
where e.department_id = d.DEPARTMENT_ID;

-- �� �� �̻��� ���̺��� ������ �ϳ��� ����� ������ �� �� join�� ����. ������ �ý��� ���ɿ��� ���� �ʴ�.
-- ���� ������ n(���̺��� ����)-1�̴�.
-- ����Ŭ join ���� 

-- �������
 --5.select
 --1. from
 --2.  where
 --3.  group by
 --4.  having
 --6. order by
 
 --�μ��� ��ձ޿��� ���Ͻÿ�.
 select department_id, avg(salary)
 from employees
 group by department_id;
 
 --90�� �μ��� ������ �μ��� ��ձ޿��� ���Ͻÿ�.
 select department_id, avg(salary)
 from employees
where department_id <> 90
group by department_id;

--90�� �μ��� ���� �� �μ��� ��ձ޿��� 5000�̻��� ��츦 ���Ͻÿ�.
select department_id, avg(salary)
from employees
where department_id <>90
group by department_id 
having avg(salary) > 5000;

--<��������>  �������� / �񵿵�����

--�����ȣ, ����̸�, �μ����� ����ϼ���.
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

create table emptest(
id number(10),
no number(10),
primary key(id, no)); -- primary key ���� �� ��, 2���� Į���� ���ļ� ����� ��
desc emptest;
