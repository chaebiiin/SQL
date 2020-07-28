--20-07-28 오전

--사원 테이블에서 사원이름, 부서명을 출력(단, sql 표준 조인 구문 사용)
select e.last_name, d.department_name from employees e, departments d
where e.department_id = d.department_id;

--풀이 1. Natural
select e.last_name, d.department_name 
from employees e natural Join departments d; 
--두 테이블 사이의 데이터 유형이 동일한 컬럼이 한개 일 경우 natural join

--풀이 2.Using
select e.last_name, d.department_name 
from employees e  Join departments d
                              using(department_id);
--풀이 3. On                            
select e.last_name, d.department_name 
from employees e  Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);                               
--실제로 조인하는 컬럼을 명시적으로 조인조건을 적고자 할 때, on을 적는다. (ON절 조인은 할 줄 알아야 한다.)

--Oracle join
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;
--from절에 join 조건을 적는게 아니라 where 절에다가 join조건을 적는다

/*outer 조인은 정말 필요할 때 외에는 잘 쓰이지 않는다.
--사원 테이블에서 사원이름, 부서명을 출력(단, sql 표준 조인 구문 사용 + 부서에 소속되지 않은 사원도 출력해야한다.(부서 미배정자)) */
select e.last_name, d.department_name 
from employees e  left outer Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);    
                            
--사원 테이블에서 사원이름, 부서명을 출력(단, sql 표준 조인 구문 사용 + 사원이 없는 부서 출력) 
select e.last_name, d.department_name 
from employees e  right outer Join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);   
                            
--Oracle join (부서 미 배정자 출력)(oracle 에서는 full outer join이 없다.) 
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;                           

--Full Outer join
select e.last_name, d.department_name 
from employees e  full outer join departments d
                            on(e.DEPARTMENT_ID = d.DEPARTMENT_ID);    
                            
                            
/*서브쿼리 (subquery) 메인 쿼리 안의 또 다른 쿼리를 서브쿼리라고 한다.
where, having, from 절에서 서브쿼리 작성
서브쿼리의 예(테이블 구조를 복사해서 만들 때(릴레이션 스키마를 만들고자 할 때 아래의 내용의 쿼리를 사용한다.))
서브쿼리를 자주 이용해라 */
create table test
as
  select * from employees
  where employee_id = 0;

select * from departments;
--서브쿼리를 이용한 업데이트. (안 됨)
update employees
set  department_id =  (select department_id 
                              from departments
                             where department_name = 'IT') --바꾸고자 하는 값
where department_id = (select department_id 
                                from departments
                               where department_name = 'PROG');  -- 기존의 값
                               
select * from employ;


--사원들 중에서 영업팀과 회계팀에 소속된 사원의 사원번호, 사원이름 출력하시오. 
select empid, empname
from employ
where deptid in (select deptid from depart where deptname  in ('영업팀', '회계팀'));

-- 다른 방법
select empid, empname
from employ
where deptid in (select deptid from depart where deptname  = '영업팀'
                                                                      or deptname = '회계팀');

/*10시 수업
-- 스칼라 서브쿼리란? SELECT 문에서 사용하는 서브쿼리로 1행만 반환
부서별 최소 급여를 출력, 부서이름, 최소급여 출력 (스칼라 서브쿼리를 사용) */
select department_name, (select min(salary)
                                    from employees
                                    where department_id = d.department_id)
from departments d;

--PL/SQL
set serveroutput on
set autoprint on
/*다시 한 번 보기
    accept (치환 변수에 사용 될 변수명);*/
    
-- 바인드 변수 호스트 환경에서 변수 지정   
--variable g_monthly_sal number
--치환변수 accept를 사용하면 입력한 값을 가지고 계속 쓴다는 것.
accept p_annual_sal prompt 'Please enter the annual salary : '

declare v_sal number(9,2) := &p_annual_sal;
begin :g_monthly_sal := v_sal/12;
dbms_output.put_line ('The monthly salary is ' || to_char(v_sal));
end;
/

declare v_annual_sal NUMBER (9,2); -- 초기값 설정?
BEGIN
/* 20-07-28 11시 수업 */
v_annual_sal := 20000; -- 값 지정
DBMS_OUTPUT.PUT_LINE(v_annual_sal);  --v_annual_sal 출력
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
DBMS_OUTPUT.PUT_LINE('Total salary : ' || v_total_salary); --문자형으로 들어가 있더라도 값이 숫자이면 암시적으로 변환해서 처리해 준다. 
END;
/

DECLARE
v_salary NUMBER(6):=6000;
v_sal_hike VARCHAR2(20):='원 입니다.';
v_total_salary v_sal_hike%TYPE;
BEGIN
v_total_salary:=v_salary || v_sal_hike;
DBMS_OUTPUT.PUT_LINE(v_total_salary);
END;
/

DECLARE
v_outer_variable VARCHAR2(20):='GLOBAL VARIABLE'; --전역 변수?
BEGIN
DECLARE
v_inner_variable VARCHAR2(20):='LOCAL VARIABLE'; --지역 변수
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
DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth); --동일한 변수명이 있다면, 재 선언 된 내용으로 출력 되어 짐 (02/12/12)
DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name); --Mike
END;
DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth); --내부선언되어진 건 출력이 되지 않고 최 상위에 선언 되어진게 출력 됨.(72/02/04)

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
--DBMS_OUTPUT.PUT_LINE('v_total_comp2: ' ||v_total_comp); 오류남
DBMS_OUTPUT.PUT_LINE('v_message2: ' ||v_message);
END;
/
/* 하위블럭
v_message ->CLERK not eligible for commission
v_comm -> 15000
v_total_comp ->50000

상위블럭
v_message ->SALESMAN, CLERK not eligible for commission
v_comm ->12,000
v_total_comm -> 실행 안 됨.
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
상위블록
v_weight ->50001
v_message ->Product 11001
v_new_locn ->  WesternEurope

하위블록
v_weight ->601
v_message ->
v_new_locn -> 실행 안 됨 오류
*/