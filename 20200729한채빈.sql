set serveroutput on
set autoprint on

--����1. ������ 1��~10���� ����ϴ� ����� �ۼ��Ͻÿ�.(¦���� ���)
begin
for i in 1..10 loop
  if mod(i,2)=0 then
      dbms_output.put_line('------------------');
     dbms_output.put_line(i||'��');
     for j in 1..9 loop
        
        dbms_output.put_line(i ||'X' || j || '= ' || (i*j));
     end loop;
    end if;
end loop;

end;
/
  
--����2. ������ ���� ������� ��� �Ͻÿ�.
--�ٸ� ����� ã�� ����.
declare
 v_star varchar(20) :='AAAAA';
  begin
    for i in  1..5 loop
     dbms_output.put_line(v_star); 
        v_star := SUBSTR(v_star, 1, 5-i);
          
  end loop;
end;
/

--����3. ������ ���Ǹ� ���� �������� ���, �޿��� �Է��ϸ� employees ���̺� ���� ����� �޿��� ���� �� �� �ֵ��� ���α׷��� �ۼ��ϼ���.
declare
v_empid employees.employee_id%type;
v_salary employees.salary%type;
begin
update employees  set salary=&v_salary  where employee_id=&v_empid; 
end;
/
select * from employees where employee_id = 149;

--����4. �ֹε�Ϲ�ȣ�� �Է¹����� 9911021234567�� �Է¹޾� 991102-1******�� ����ϴ� ���α׷��� �ۼ��ϼ���.
--�ٸ� ����� ã�ƺ��� �� ��...
declare
v_number varchar(20) :=&v_number;
begin
v_number:=substr(v_number,1,6)||'-'||substr(v_number,7);
dbms_output.put_line(v_number);
v_number :=replace(v_number,substr(v_number,9,5), '******');
dbms_output.put_line(v_number);
end;
/

SELECT REGEXP_REPLACE('9006301111111', '(\d{6})(\d{1})(\d{6})', '\1-\2****** ') AS �ֹι�ȣ
FROM DUAL;
