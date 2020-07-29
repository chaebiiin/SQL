--7�� 29��
--while loop
set serveroutput on
set autoprint on

DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
v_counter NUMBER := 1;
BEGIN
SELECT MAX(location_id) INTO v_loc_id FROM locations
WHERE country_id = v_countryid;
WHILE v_counter <= 3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
v_counter := v_counter + 1;
END LOOP;
END;
/
select * from locations;

--FOR Loops
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
BEGIN
SELECT MAX(location_id) INTO v_loc_id
FROM locations
WHERE country_id = v_countryid;
FOR i IN 1..3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((v_loc_id + i), v_new_city, v_countryid );
END LOOP;
END;
/
select * from locations;

declare
  p_sum number := 0;
BEGIN
  for i in 1..10 loop
    p_sum := p_sum+i; --p_sum+= i;
 end loop;
    dbms_output.put_line(p_sum);
 end;
 /
 
 --����1. ��ǥ ���
 declare
  j varchar(20) :='��';
begin
  for i in 1..5 loop
    --j := j;
    dbms_output.put_line(j);
      j := j ||'��';
end loop;
end;
/

--����2.  ���������
declare
  one number(10) := 0;
  two number(10) :=0;
begin
for i in 2..9 loop
one := one+i;
dbms_output.put_line('<'||i || '��>');
for j in 1..9 loop
two := two+j;
--dbms_output.put_line(i);
dbms_output.put_line(i ||'X' || j || '= ' || (i*j));

end loop;
end loop;
end;
/
--����3. employees���� �����ȣ�� �޾Ƽ� �Ի�⵵�� 2005�� ���Ŀ� �Ի�� ��new employee�� �ƴϸ� 'career employee'�̶�� ����Ͻÿ�.

declare
  v_empid employees.hire_date%type;  
begin
    select hire_date into v_empid
    from employees 
    where employee_id=149;
dbms_output.put_line(v_empid);

if  v_empid > to_date('20050101','yyyy/mm/dd')
  then 
  dbms_output.put_line('new');
  else
  dbms_output.put_line('old');
  end if;
end;
/

/* ����4.�����ȣ�� �Է¹޾� �μ��̸�, job_id, �޿�, ���� �Ѽ���(�޿�*���ʽ�*12)�� 
����ϴ� PL/SQL Block�� �ۼ��ϼ���. �޿��� Ŀ�̼��� Null�� ������ ���� ��µǵ��� �ϼ���. 
*/
declare 
v_empid employees.employee_id%type;
v_department_id departments.department_id%type;
v_job_id employees.job_id%type;
v_salary employees.salary%type;
v_sumsal employees.salary%type;
begin
  select employee_id, department_id, job_id, salary, salary*(nvl(COMMISSION_PCT,0)+1)*12 into v_empid, v_department_id,v_job_id
  ,v_salary, v_sumsal
  from employees where employee_id=149;
    dbms_output.put_line(v_empid ||','|| v_department_id ||','|| v_job_id ||','|| v_salary ||','|| v_sumsal);
end;
 /

declare 
v_input number(9,2) := 149;
v_empid employees.employee_id%type;
v_department_name departments.department_name%type;
v_job_id employees.job_id%type;
v_salary employees.salary%type;
v_sumsal employees.salary%type;
begin
    select e.employee_id, d.department_name, e.job_id, e.salary, e.salary*(nvl(COMMISSION_PCT,0)+1)*12 into v_empid, v_department_name,v_job_id,v_salary, v_sumsal
  from employees e, departments d where employee_id=&v_input and  e.department_id = d.department_id;
    dbms_output.put_line(v_empid ||', '|| v_department_name ||', '|| v_job_id ||', '|| v_salary ||', '|| v_sumsal);
end;
 /

--����5. ����� �Է¹����� ����� �̸� �Ϻκ��� *�� ���ܼ� ǥ���ϴ� PL/SQL ���α׷��� �ۼ��ϼ���.  ��: Maurgos -> M***gos

declare
v_input number(9,2) := 149;
v_empid employees.employee_id%type;
v_lastname employees.last_name%type;
begin
select  employee_id, replace(last_name, substr(last_name, 2,3),'*') "last_name" into v_empid, v_lastname   from employees
where v_empid = &v_input;
   dbms_output.put_line(v_empid||v_lastname); 
end;
/

select replace(last_name, substr(last_name, 2,3),'*') "last_name"  from employees;
