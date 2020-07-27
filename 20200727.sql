--문제1 테이블 구조와 같은 테이블을 생성하는 sql문을 작성하시오.

create table depart(
        deptid number(10) primary key,
        deptname varchar2(10),
        location varchar2(10),
        tel varchar2(15));
desc depart;

--문제3 조회된 결과와 같은 데이터를 입력하는 sql문
insert into depart values(1001, '총무팀', '본101호', '053-777-8777');
insert into depart values(1002, '회계팀', '본102호', '053-888-9999');
insert into depart values(1003, '영업팀', '본103호', '053-222-333');

select * from depart;

--문제1 테이블 구조와 같은 테이블을 생성하는 sql문을 작성하시오. 

create table employ(
        empid number(10) primary key,
        empname varchar2(10),
        hiredate date,
        addr varchar2(12),
        tel varchar2(15),
        deptid number(10), foreign key(deptid) references depart(deptid));
desc employ;     

--추 후 지정하는 법 알아보기        
--alter table employ
--  add CONSTRAINT deptid_fk foreign key(deptid) references (depart);


--문제3 조회된 결과와 같은 데이터를 입력하는 sql문
insert into employ values(20121945, '박민수', '20120302', '대구','010-777-8777', 1001);
insert into employ values(20101817, '박준식', '20100901', '경산','010-888-9999',1003);
insert into employ values(20122245, '선아라', '20120302','대구', '010-2222-3333', 1002);
insert into employ values(20121729, '이범수', '20110302','서울', '010-3333-4444', 1001);
insert into employ values(20121646, '이융희', '20120911','부산', '010-1234-2223', 1003);
select * from employ;

--문제2 직원(employ) 테이블에 생년월일 칼럼을 추가하는 sql문 작성 (뭐가 잘 못 된지 모르겠음.)
alter table employ add (birthday date);

--문제4 직원테이블(employ)의 직원명(empname) 칼럼에 not null 제약조건을 추가하시오.
alter table employ modify (empname not null); 

--문제5. 총무팀에 근무하는 직원의 이름, 입사일, 부서명을 출력하시오.
--조인 조건이 빠짐. 조인 조건을 넣어줘야함  (어떻게 해야할지 모름)
select e.empname, e.hiredate, d.deptname
from employ e, depart d
where e.deptid = d.deptid
and (select deptname from depart where deptname IN '총무팀');

--문제6 직원 테이블에서 "대구"에서 살고 있는 직원을 모두 삭제하시오. (해결)
delete from employ
where addr = '대구';

--문제7 직원 테이블에서 "영업팀"에 근무하는 직원을 모두 "회계팀으로" 수정하는 sql문을 작성하세요. (해결)
update employ 
set  deptid = (select deptid from depart where deptname= '회계팀')
where deptid = (select deptid from depart where deptname = '영업팀');

--문제8 직원 테이블에서 직원번호가 "20121729"인 직원의 입사일보다 늦게 입사한 직원의 
--직원번호, 이름, 생년월일, 부서이름을 출력하는 sql문 (deptname이 왜 다 나오는지 잘 모르겠음.)
select e.empid, e.empname, e.birthday, d.deptname, e.hiredate
from employ e, depart d
where hiredate > (select hiredate from employ where empid = '20121729');


--문제9 총무팀에 근무하는 직원의 이름, 주소, 부서명을 볼 수 있는 뷰를 생성하시오. (잘 모르겠음.) (조인 조건을 넣어야함)
create view view_deptname
as
select e.empname, e.addr, d.deptname
from employ e, depart d
where d.deptname in '총무팀';






--오후 수업
select e.employee_id,e.last_name, d.department_name from  departments d, employees e
where  e.department_id = d.department_id
and e.salary > (select salary from employees where employee_id = 176);

-- 부서이름에 it가 들어가는 부서의 사원 급여, 사원 이름 출력 
SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id
FROM departments
WHERE lower(department_name)='it');

-- 사원들 중에서 's'가 들어가는 사원의 이름, 부서명을 출력하시오. 단, 'Steven' 사원이 있는 부서는 제외,
-- 단 's'는 소문자 또는 대문자 일 수 있다.

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

-- 두 개 이상의 테이블을 가지고 하나의 결과를 보고자 할 때 join을 쓴다. 하지만 시스템 성능에는 좋지 않다.
-- 조인 조건은 n(테이블의 개수)-1이다.
-- 오라클 join 조건 

-- 실행순서
 --5.select
 --1. from
 --2.  where
 --3.  group by
 --4.  having
 --6. order by
 
 --부서별 평균급여를 구하시오.
 select department_id, avg(salary)
 from employees
 group by department_id;
 
 --90번 부서를 제외한 부서별 평균급여를 구하시오.
 select department_id, avg(salary)
 from employees
where department_id <> 90
group by department_id;

--90번 부서를 제외 한 부서별 평균급여가 5000이상인 경우를 구하시오.
select department_id, avg(salary)
from employees
where department_id <>90
group by department_id 
having avg(salary) > 5000;

--<조인조건>  동등조인 / 비동등조인

--사원번호, 사원이름, 부서명을 출력하세요.
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

create table emptest(
id number(10),
no number(10),
primary key(id, no)); -- primary key 지정 할 때, 2개의 칼럼을 합쳐서 만드는 법
desc emptest;
