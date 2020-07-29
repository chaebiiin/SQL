set serveroutput on
set autoprint on

--문제1. 구구단 1단~10단을 출력하는 블록을 작성하시오.(짝수만 출력)
begin
for i in 1..10 loop
  if mod(i,2)=0 then
      dbms_output.put_line('------------------');
     dbms_output.put_line(i||'단');
     for j in 1..9 loop
        
        dbms_output.put_line(i ||'X' || j || '= ' || (i*j));
     end loop;
    end if;
end loop;

end;
/
  
--문제2. 다음과 같은 모양으로 출력 하시오.
--다른 방법도 찾아 보기.
declare
 v_star varchar(20) :='AAAAA';
  begin
    for i in  1..5 loop
     dbms_output.put_line(v_star); 
        v_star := SUBSTR(v_star, 1, 5-i);
          
  end loop;
end;
/

--문제3. 직원의 편의를 위해 직원들이 사번, 급여만 입력하면 employees 테이블에 쉽게 사원의 급여를 갱신 할 수 있도록 프로그램을 작성하세요.
declare
v_empid employees.employee_id%type;
v_salary employees.salary%type;
begin
update employees  set salary=&v_salary  where employee_id=&v_empid; 
end;
/
select * from employees where employee_id = 149;

--문제4. 주민등록번호를 입력받으면 9911021234567를 입력받아 991102-1******로 출력하는 프로그램을 작성하세요.
--다른 방법을 찾아봐야 할 듯...
declare
v_number varchar(20) :=&v_number;
begin
v_number:=substr(v_number,1,6)||'-'||substr(v_number,7);
dbms_output.put_line(v_number);
v_number :=replace(v_number,substr(v_number,9,5), '******');
dbms_output.put_line(v_number);
end;
/

SELECT REGEXP_REPLACE('9006301111111', '(\d{6})(\d{1})(\d{6})', '\1-\2****** ') AS 주민번호
FROM DUAL;
