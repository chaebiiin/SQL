--20-07-28 ����

--��� ���̺��� ����̸�, �μ����� ���(��, sql ǥ�� ���� ���� ���)
select e.last_name, d.department_name from employees e, departments d
where e.department_id = d.department_id;

--Ǯ�� 1. Natural
select e.last_name, d.department_name 
from employees e natural Join departments d; 
--�� ���̺� ������ ������ ������ ������ �÷��� �Ѱ� �� ��� natural join

--Ǯ�� 2.Using
select e.last_name, d.department_name 
from employees e  Join departments d
                              using(department_id);
--Ǯ�� 3. On                            
select e.last_name, d.department_name 
from employees e  Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);                               
--������ �����ϴ� �÷��� ��������� ���������� ������ �� ��, on�� ���´�. (ON�� ������ �� �� �˾ƾ� �Ѵ�.)

--Oracle join
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;
--from���� join ������ ���°� �ƴ϶� where �����ٰ� join������ ���´�

/*outer ������ ���� �ʿ��� �� �ܿ��� �� ������ �ʴ´�.
--��� ���̺��� ����̸�, �μ����� ���(��, sql ǥ�� ���� ���� ��� + �μ��� �Ҽӵ��� ���� ����� ����ؾ��Ѵ�.(�μ� �̹�����)) */
select e.last_name, d.department_name 
from employees e  left outer Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);    
                            
--��� ���̺��� ����̸�, �μ����� ���(��, sql ǥ�� ���� ���� ��� + ����� ���� �μ� ���) 
select e.last_name, d.department_name 
from employees e  right outer Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);   
                            
--Oracle join (�μ� �� ������ ���)(oracle ������ full outer join�� ����.) 
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;                           

--Full Outer join
select e.last_name, d.department_name 
from employees e  full outer join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);    
                            
                            
/*�������� (subquery) ���� ���� ���� �� �ٸ� ������ ����������� �Ѵ�.
where, having, from ������ �������� �ۼ�
���������� ��(���̺� ������ �����ؼ� ���� ��(�����̼� ��Ű���� ������� �� �� �Ʒ��� ������ ������ ����Ѵ�.))
���������� ���� �̿��ض� */
create table test
as
  select * from employees
  where employee_id = 0;

select * from departments;
--���������� �̿��� ������Ʈ. (�� ��)
update employees
set  department_id =  (select department_id 
                              from departments
                             where department_name = 'IT') --�ٲٰ��� �ϴ� ��
where department_id = (select department_id 
                                from departments
                               where department_name = 'PROG');  -- ������ ��
                               
select * from employ;


--����� �߿��� �������� ȸ������ �Ҽӵ� ����� �����ȣ, ����̸� ����Ͻÿ�. 
select empid, empname
from employ
where deptid in (select deptid from depart where deptname  in ('������', 'ȸ����'));

-- �ٸ� ���
select empid, empname
from employ
where deptid in (select deptid from depart where deptname  = '������'
                                                                      or deptname = 'ȸ����');

/*10�� ����
-- ��Į�� ����������? SELECT ������ ����ϴ� ���������� 1�ุ ��ȯ
�μ��� �ּ� �޿��� ���, �μ��̸�, �ּұ޿� ��� (��Į�� ���������� ���) */
select department_name, (select min(salary)
                                    from employees
                                    where department_id = d.department_id)
from departments d;

--PL/SQL
set serveroutput on
set autoprint on
/*�ٽ� �� �� ����
    accept (ġȯ ������ ��� �� ������);*/
    
-- ���ε� ���� ȣ��Ʈ ȯ�濡�� ���� ����   
--variable g_monthly_sal number
--ġȯ���� accept�� ����ϸ� �Է��� ���� ������ ��� ���ٴ� ��.
accept p_annual_sal prompt 'Please enter the annual salary : '

declare v_sal number(9,2) := &p_annual_sal;
begin :g_monthly_sal := v_sal/12;
dbms_output.put_line ('The monthly salary is ' || to_char(v_sal));
end;
/

declare v_annual_sal NUMBER (9,2); -- �ʱⰪ ����?
BEGIN
/* 20-07-28 11�� ���� */
v_annual_sal := 20000; -- �� ����
DBMS_OUTPUT.PUT_LINE(v_annual_sal);  --v_annual_sal ���
END;
/

DECLARE
v_salary NUMBER(6):=6000;
v_sal_hike VARCHAR2(5):='1000';
v_total_salary v_salary%TYPE;
BEGIN
v_total_salary:=v_salary + v_sal_hike;
DBMS_OUTPUT.PUT_LINE( v_salary || v_sal_hike);
DBMS_OUTPUT.PUT_LINE('v_salary: ' || v_salary ||',  '|| 'v_sal_hike: '|| v_sal_hike);
DBMS_OUTPUT.PUT_LINE('Total salary : ' || v_total_salary); --���������� �� �ִ��� ���� �����̸� �Ͻ������� ��ȯ�ؼ� ó���� �ش�. 
END;
/

DECLARE
v_salary NUMBER(6):=6000;
v_sal_hike VARCHAR2(20):='�� �Դϴ�.';
v_total_salary v_sal_hike%TYPE;
BEGIN
v_total_salary:=v_salary || v_sal_hike;
DBMS_OUTPUT.PUT_LINE(v_total_salary);
END;
/

DECLARE
v_outer_variable VARCHAR2(20):='GLOBAL VARIABLE'; --���� ����?
BEGIN
DECLARE
v_inner_variable VARCHAR2(20):='LOCAL VARIABLE'; --���� ����
BEGIN
DBMS_OUTPUT.PUT_LINE(v_inner_variable); --LOCAL VARIABLE
DBMS_OUTPUT.PUT_LINE(v_outer_variable); --GLOBAL VARIABLE
END;
DBMS_OUTPUT.PUT_LINE(v_outer_variable); --GLOBAL VARIABLE
END;
/


DECLARE
v_father_name VARCHAR2(20):='Patrick';
v_date_of_birth DATE:= to_date('1972-02-04','yyyy-mm-dd');
BEGIN
DECLARE
v_child_name VARCHAR2(20):='Mike';
v_date_of_birth DATE:= to_date( '2002-12-12','yyyy-mm-dd');
BEGIN
DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name); --Patrick
DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth); --������ �������� �ִٸ�, �� ���� �� �������� ��� �Ǿ� �� (02/12/12)
DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name); --Mike
END;
DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth); --���μ���Ǿ��� �� ����� ���� �ʰ� �� ������ ���� �Ǿ����� ��� ��.(72/02/04)

END;
/


DECLARE
v_sal NUMBER(7,2) := 60000;
v_comm NUMBER(7,2) := v_sal * 0.20;
v_message VARCHAR2(255) := ' eligible for commission';
BEGIN

DECLARE
v_sal NUMBER(7,2) := 50000;
v_comm NUMBER(7,2) := 0;
v_total_comp NUMBER(7,2) := v_sal + v_comm;

BEGIN
v_message := 'CLERK not'||v_message;
v_comm := v_sal * 0.30; 
DBMS_OUTPUT.PUT_LINE('v_sal1 : ' ||v_sal);
DBMS_OUTPUT.PUT_LINE('v_comm1: ' ||v_comm);
DBMS_OUTPUT.PUT_LINE('v_message1: ' ||v_message);
DBMS_OUTPUT.PUT_LINE('v_total_comp1: ' ||v_total_comp);
DBMS_OUTPUT.PUT_LINE('-------------------');
END;
v_message := 'SALESMAN, '||v_message;
DBMS_OUTPUT.PUT_LINE('v_sal2 : ' ||v_sal);
DBMS_OUTPUT.PUT_LINE('v_comm2: ' ||v_comm);
--DBMS_OUTPUT.PUT_LINE('v_total_comp2: ' ||v_total_comp); ������
DBMS_OUTPUT.PUT_LINE('v_message2: ' ||v_message);
END;
/
/* ������
v_message ->CLERK not eligible for commission
v_comm -> 15000
v_total_comp ->50000

������
v_message ->SALESMAN, CLERK not eligible for commission
v_comm ->12,000
v_total_comm -> ���� �� ��.
*/

DECLARE
    v_weight NUMBER(3) := 600;
    v_message VARCHAR2(255):='Product 10012';
BEGIN
  DECLARE
    v_weight NUMBER(7,2) := 50000;
   v_message VARCHAR2(255) := 'Product 11001';
   v_new_locn VARCHAR2(50) := 'Europe';
BEGIN
  v_weight := v_weight + 1;
  v_new_locn := 'Western' || v_new_locn;
DBMS_OUTPUT.PUT_LINE('v_weight1: ' ||v_weight);
DBMS_OUTPUT.PUT_LINE('v_message1: ' ||v_message);
DBMS_OUTPUT.PUT_LINE('v_new_locn1: ' ||v_new_locn);
DBMS_OUTPUT.PUT_LINE('========================');
END;
  v_weight := v_weight + 1;
  v_message := v_message || ' + is in stock';
  DBMS_OUTPUT.PUT_LINE('v_weight2: ' ||v_weight);
DBMS_OUTPUT.PUT_LINE('v_message2: ' ||v_message);
 --v_new_locn := 'Western'|| v_new_locn;
END;

/*
�������
v_weight ->50001
v_message ->Product 11001
v_new_locn ->  WesternEurope

�������
v_weight ->601
v_message ->
v_new_locn -> ���� �� �� ����
*/