--0730 오전수업
set serveroutput on
set autoprint on

DECLARE
    CURSOR c_emp_cursor IS
        SELECT employee_id, last_name FROM employees
        WHERE department_id=90;
        v_emp_record c_emp_cursor%ROWTYPE;
BEGIN
    OPEN c_emp_cursor;
    LOOP
        FETCH c_emp_cursor INTO v_emp_record;
       EXIT WHEN c_emp_cursor%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id
                                                             ||', '||v_emp_record.last_name);
     END LOOP;
    CLOSE c_emp_cursor;
END;
/

DECLARE
      CURSOR c_emp_cursor IS SELECT employee_id,
                last_name FROM employees;
        v_emp_record c_emp_cursor%ROWTYPE;
BEGIN
    OPEN c_emp_cursor;
    LOOP
      FETCH c_emp_cursor INTO v_emp_record;
        EXIT WHEN c_emp_cursor%ROWCOUNT > 10 OR
                                          c_emp_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE( v_emp_record.employee_id
                                                            ||' '||v_emp_record.last_name);
    END LOOP;
    CLOSE c_emp_cursor;
END ; 
/

DECLARE
    CURSOR c_emp_cursor IS
      SELECT employee_id, last_name FROM employees
      WHERE department_id =90;
 
BEGIN
    FOR emp_record IN c_emp_cursor
      LOOP
        DBMS_OUTPUT.PUT_LINE( emp_record.employee_id
                                              ||' , ' ||emp_record.last_name);
      END LOOP;
END;
/

--문제1. 50번 부서에 근무하는 사원의 사원번호, 사원이름을  emp_test 테이블로 저장하시오.
drop table emp_test;
CREATE TABLE emp_test(empno, ename)
AS
    SELECT employee_id, last_name
    FROM employees
    WHERE employee_id=0;
DECLARE
      CURSOR c_emp_cursor IS
        SELECT employee_id, last_name 
        FROM employees
        WHERE department_id = 50;
        copy_emp c_emp_cursor%ROWTYPE;
BEGIN 
    FOR copy_emp IN c_emp_cursor
    LOOP
      INSERT INTO emp_test(empno,ename)
      VALUES(copy_emp.employee_id, copy_emp.last_name);
    END LOOP;
END;
/

SELECT * FROM emp_test;

SELECT employee_id, last_name 
FROM employees
WHERE department_id = 50;

ROLLBACK;

/* 문제2. 50번 부서에 근무하는 사원은 사원번호, 사원이름을 emp_test 테이블에 저장하고,
              60번 부서에 근무하는 사원은 사원번호,사원이름을 emp_test1 테이블에 저장              
  */  
CREATE TABLE emp_test1(empno, ename)
AS
    SELECT employee_id, last_name
    FROM employees
    WHERE employee_id=0;

DECLARE
      CURSOR c_emp_cursor IS
        SELECT employee_id, last_name, department_id
        FROM employees
        WHERE department_id IN (50,60);
        copy_emp c_emp_cursor%ROWTYPE;
BEGIN 
      FOR copy_emp IN c_emp_cursor
        LOOP
          IF copy_emp.department_id = 50 THEN
            INSERT INTO emp_test(empno,ename)
            VALUES(copy_emp.employee_id, copy_emp.last_name);
         ELSE 
            INSERT INTO emp_test1(empno,ename)
            VALUES(copy_emp.employee_id, copy_emp.last_name);
          END IF;
    END LOOP;
END;
/    
SELECT * FROM emp_test;
SELECT * FROM emp_test1;


DECLARE
     CURSOR emp_cursor IS
        SELECT employee_id, last_name FROM employees
        WHERE department_id =90;
      emp_record emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        INSERT INTO emp_test (empno, ename)
        VALUES (emp_record.employee_id, emp_record.last_name);
    END LOOP;
    COMMIT;
    CLOSE emp_cursor;
END;
/
select * from emp_test;

--deptno 칼럼이 추가
ALTER TABLE emp_test ADD (deptno NUMBER(10));

-- deptno에 값 추가
DECLARE
      CURSOR c_deptno_cursor IS
        SELECT department_id,employee_id 
        FROM employees;
        copy_deptno c_deptno_cursor%ROWTYPE;
BEGIN 
    FOR copy_deptno IN c_deptno_cursor
    LOOP
     UPDATE emp_test
     SET deptno = copy_deptno.department_id
     WHERE empno = copy_deptno.employee_id;
    END LOOP;
END;
/

--부서번호가 10
BEGIN
    FOR emp_record IN (SELECT empno, ename, deptno
                                  FROM emp_test) LOOP
       IF emp_record.deptno = 10 then
        DBMS_OUTPUT.PUT_LINE('Employee' || emp_record.ename || 'works in the Sales Dept');
       END IF;
     END LOOP;
END;
/

/*문제3. 부서번호는 매개변수를 사용해서 90번 부서에 근무하는 사원의 사원이름을 emp_test 테이블에 저장하시오.*/  
DECLARE
    CURSOR c_emp_cursor (deptno NUMBER) IS
      SELECT employee_id, last_name, department_id
      FROM employees
      WHERE department_id = deptno;
      emp_record c_emp_cursor%ROWTYPE;
      
BEGIN
  OPEN c_emp_cursor (90);
   LOOP
        FETCH c_emp_cursor INTO emp_record;
        EXIT WHEN c_emp_cursor%NOTFOUND;
        INSERT INTO emp_test (empno, ename,deptno)
        VALUES (emp_record.employee_id, emp_record.last_name, emp_record.department_id);
    END LOOP;
  CLOSE c_emp_cursor;
END;
/
SELECT * FROM emp_test;

/* 문제4. 50번 부서에 근무하는 사원의 사원번호와 이름을 emp_test 테이블에 저장하고, 10번 부서에 근무하는 사원의 사원번호와 이름을 emp_test에 저장하시오. */
DECLARE 
   CURSOR c_emp_cursor(deptno NUMBER) IS
      SELECT employee_id, last_name, department_id
      FROM employees
      WHERE department_id = deptno;
    emp_record c_emp_cursor%ROWTYPE;
BEGIN
   OPEN c_emp_cursor(50);
      LOOP
         FETCH c_emp_cursor INTO emp_record;
          EXIT WHEN c_emp_cursor%NOTFOUND;
          INSERT INTO emp_test1 (empno, ename,deptno)
          VALUES (emp_record.employee_id, emp_record.last_name, emp_record.department_id);
       END LOOP;
    CLOSE  c_emp_cursor;
  OPEN c_emp_cursor (10);
     LOOP
         FETCH c_emp_cursor INTO emp_record;
        EXIT WHEN c_emp_cursor%NOTFOUND;
        INSERT INTO emp_test1(empno, ename,deptno)
        VALUES (emp_record.employee_id, emp_record.last_name, emp_record.department_id);
    END LOOP;
    CLOSE c_emp_cursor;
END;
/



-- 오후수업~
select employee_id, salary FROM employees
where department_id = 50;
rollback;

DECLARE
    CURSOR sal_cursor IS
      SELECT salary
      FROM employees
      WHERE department_id = 50
    FOR UPDATE OF salary NOWAIT;
BEGIN
    FOR emp_record IN sal_cursor LOOP
      UPDATE employees
      SET salary = emp_record.salary * 1.10
      WHERE CURRENT OF sal_cursor;
    END LOOP;
END;
/

--예외처리~
DECLARE
    v_lname VARCHAR2(15);
BEGIN
      SELECT last_name INTO v_lname
      FROM employees
      WHERE lower(first_name)='lex';
          DBMS_OUTPUT.PUT_LINE ('lex''s last name is :' ||v_lname);
          
EXCEPTION --예외처리 해주는 부분
WHEN NO_DATA_FOUND THEN 
      DBMS_OUTPUT.PUT_LINE (' Your select statement retrieved multiple rows. Consider using a cursor.');
END;
/

--
DECLARE
    e_insert_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_insert_excep, -01400); -- (-01400)오라클 표준 오류번호를 모르는 사람이 쓰기에는 불편.
BEGIN
    INSERT INTO departments
                      (department_id, department_name) VALUES (280, NULL);
EXCEPTION
    WHEN e_insert_excep THEN
      DBMS_OUTPUT.PUT_LINE('INSERT OPERATION FAILED');
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
select * from departments;
ROLLBACK;

DECLARE
    v_deptno NUMBER := 50;
    v_name VARCHAR2(20) := 'Testing';
  e_invalid_department EXCEPTION;
BEGIN
    UPDATE departments
    SET department_name = v_name
    WHERE department_id = v_deptno;
    IF SQL%NOTFOUND THEN
      RAISE e_invalid_department;
    END IF;
    DBMS_OUTPUT.PUT_LINE('성공!');

EXCEPTION
    WHEN e_invalid_department THEN
      DBMS_OUTPUT.PUT_LINE('No such department id.');
END;
/
select * from departments;

CREATE TABLE log_table
(code NUMBER(10),
message varchar2(100),
info VARCHAR2(200));


DECLARE 
    e_toomanyemp EXCEPTION;
    v_empsal NUMBER(7);
    v_empcomm NUMBER(7);
    v_errorcode NUMBER;
    v_errortext VARCHAR2(200);
BEGIN
    SELECT salary, commission_pct
    INTO v_empsal, v_empcomm
    FROM employees
    WHERE employee_id = 1706;
    IF v_empcomm <= v_empsal THEN
        RAISE e_toomanyemp;
      END IF;
    EXCEPTION
      WHEN e_toomanyemp THEN
        INSERT INTO log_table(info)
        VALUES('이 사원은 보너스가 ' || v_empcomm || '으로 월 급여' || v_empsal || '보다 많다.');
        
        WHEN OTHERS THEN
          v_errorcode := SQLCODE;
          v_errortext := SUBSTR(SQLERRM, 1,200);
      INSERT INTO log_table
      VALUES (v_errorcode, v_errortext, 'Oracle error occurred');
END;         
/

SELECT * FROM employees 
where employee_id = 176;

select * from log_table;
DELETE FROM emp_test1; --안의 내용 지움
SELECT * FROM emp_test1;





/* 문제1. 사용자 정의 예외사항 
              특정 부서에 근무하는 사원의 사원번호와 이름을 emp_test1 테이블에 저장하시오. (단, 부서에 사원이 없을 경우 "해당부서에 사원이 없습니다." 라는 오류 메세지 발생) */
 DECLARE
 e_invalid_department EXCEPTION;
 v_deptno employees.department_id%type := &v_deptno;
 
   CURSOR c_emp_cursor(i_deptno NUMBER) IS
      SELECT employee_id, last_name, department_id
      FROM employees
      WHERE department_id = i_deptno;
    emp_record c_emp_cursor%ROWTYPE;
    
BEGIN
   OPEN c_emp_cursor(v_deptno);
      LOOP
         FETCH c_emp_cursor INTO emp_record;
          EXIT WHEN c_emp_cursor%NOTFOUND;
          INSERT INTO emp_test1(empno, ename,deptno)
          VALUES (emp_record.employee_id, emp_record.last_name, emp_record.department_id);  
      
      END LOOP; 
      
      IF c_emp_cursor%NOTFOUND THEN 
            RAISE e_invalid_department;
         END IF;
  
EXCEPTION
    WHEN e_invalid_department THEN
      DBMS_OUTPUT.PUT_LINE('No such department id.');
      CLOSE  c_emp_cursor;
END;
/

SELECT * FROM emp_test1;

/* 문제2. emp_test1에서 사원번호을 삭제하시오. 단 사용자 정의 예외사항 사용. 단, 사원이 없으면 "해당사원이 없습니다."라는 오류 메세지 발생 */
DECLARE
  e_invalid_department EXCEPTION;
  v_empno emp_test1.empno%type;
  v_deptno emp_test1.deptno%type;
BEGIN
    DELETE FROM emp_test1 WHERE empno = &v_empno; 
    
      IF SQL%NOTFOUND THEN 
            RAISE e_invalid_department;
         END IF;
  
EXCEPTION
    WHEN e_invalid_department THEN
      DBMS_OUTPUT.PUT_LINE('No!!!! 해당사원이 없습니다.');
END;
/
--IN  매개변수
CREATE OR REPLACE PROCEDURE raise_salary --자바의 메소드랑 비슷?
    (p_id IN employees.employee_id%TYPE, -- IN으로  매개변수는 값을 받을 때 쓴다? 
      p_percent IN NUMBER)
    IS
BEGIN
      UPDATE employees
      SET salary = salary * (1 + p_percent/100)
      WHERE employee_id = p_id;
END raise_salary; -- 끝날 때, procedure 명 을 꼭 적어줘야 한다.
/
EXECUTE raise_salary(176, 10) --176번 사원의 급여를 10퍼센트 인상 
ROLLBACK;
SELECT *FROM employees;

------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE query_emp
    (p_id IN employees.employee_id%type,
      p_name OUT employees.last_name%type,
      p_salary OUT employees.salary%type) IS
BEGIN
    SELECT last_name, salary INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_id;
END query_emp;
/
------------------------------------------------------------------------------
SET SERVEROUTPUT ON

DECLARE
    v_emp_name employees.last_name%TYPE;
    v_emp_sal employees.salary%TYPE;
BEGIN
    query_emp(176, v_emp_name, v_emp_sal);
      DBMS_OUTPUT.PUT_LINE(v_emp_name||' earns '|| to_char(v_emp_sal, '$999,999.00'));
END;
/

--------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE format_phone
            (p_phone_no IN OUT VARCHAR2) IS
BEGIN
              p_phone_no := '(' || SUBSTR(p_phone_no,1,3) || ') ' || SUBSTR(p_phone_no,4,3) ||
                                    '-' || SUBSTR(p_phone_no,7);
END format_phone;
/
---------------------------------------------------------------------------
VARIABLE b_phone_no VARCHAR2(15)
EXECUTE :b_phone_no := '8006330575'
PRINT b_phone_no
EXECUTE format_phone (:b_phone_no)
PRINT b_phone_no
--------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE add_dept (
    p_name IN departments.department_name%TYPE,
    p_loc IN departments.location_id%TYPE) IS
BEGIN
    INSERT INTO departments(department_id,
                                        department_name, location_id)
     VALUES (departments_seq.NEXTVAL, p_name, p_loc);
 END add_dept;
 /
 --------------------------------------------------------------------------
EXECUTE add_dept ('TRAINING', 2500);
EXECUTE add_dept (p_loc=>2500, p_name=>'TRAINING');
---------------------------------------------------------------------------
select * from departments;
---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE process_employees
    IS
      CURSOR cur_emp_cursor IS
        SELECT employee_id
        FROM employees;
BEGIN
      FOR emp_rec IN cur_emp_cursor
      LOOP
        raise_salary(emp_rec.employee_id, 10);
      END LOOP;
END process_employees;
/
---------------------------------------------------------------------------
EXECUTE process_employees; --실행하는 부분

select * from employees;

DROP PROCEDURE raise_salary;
DROP PROCEDURE process_employees;




/*문제3. 직원의 편의를 위해 직원들이 사번, 급여 증가치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신 할 수 있도록 프로그램을 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.
*/

CREATE OR REPLACE PROCEDURE raise_salary   
    (v_empid IN employees.employee_id%TYPE, 
      p_percent IN NUMBER)
  IS
  e_invalid_department EXCEPTION;
BEGIN
      UPDATE employees
      SET salary = salary * (1 + p_percent/100)
      WHERE employee_id = v_empid;
       IF SQL%NOTFOUND THEN 
            RAISE e_invalid_department;
         END IF;
  
EXCEPTION
    WHEN e_invalid_department THEN
      DBMS_OUTPUT.PUT_LINE('No!!!! 해당사원이 없습니다.');
END raise_salary; 
/
EXECUTE raise_salary(&v_empid, &p_percent);

select * from employees where employee_id = 176;