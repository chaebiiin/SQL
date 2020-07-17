--테이블 만들기
CREATE TABLE bigemp
AS
SELECT * FROM employees;
--테이블 안의 내용 채우기 (여러번 해줌)
INSERT INTO bigemp
SELECT * FROM bigemp;

COMMIT;
--테이블 안의 사원번호 정렬하기 (1001번 부터 시작해서 1씩증가)
CREATE SEQUENCE emp_id_deq
START WITH 1001
INCREMENT BY 1;
-- 테이블 별칭 이름 지정함
UPDATE bigemp
SET employee_id = emp_id_deq.nextval;
COMMIT;
--사원번호가 작은사람과 큰 사람 출력해 봄
SELECT MIN(employee_id), MAX(employee_id)
FROM bigemp;

--인덱스 만들 기 전 권한 부여해주기 run comm에서
--conn / as sysdba
--GRANT SELECT_CATALOG_ROLE TO hr;
--GRANT SELECT ANY DICTIONARY TO hr;

SELECT index_name FROM user_indexes
WHERE table_name = 'BIGEMP';

--인덱스 만들기 전 자동추적 확인
SELECT* FROM bigemp
WHERE employee_id = 234567;
--인덱스 만들기
CREATE INDEX bigemp_id_ix
ON bigemp(employee_id);
--인덱스 만들고 나서 자동추적 확인
SELECT* FROM bigemp
WHERE employee_id = 234567;
--인덱스 만들기 전 자동추적해보기
SELECT* FROM bigemp
WHERE salary = 3000;
--인덱스 만들기
CREATE INDEX bigemp_sal_ix
ON bigemp(salary);
--인덱스 만들고 난 후 자동추적해보기
SELECT* FROM bigemp
WHERE salary = 3000;
--인덱스에 저장된 값이 아닌 다른 값을 조회하면 풀 스캔함...
SELECT* FROM bigemp
WHERE salary*12 > 110000;
--앞에서 만든 인덱스 삭제
DROP INDEX bigemp_sal_ix;
--월급*12 값을 인덱스로 설정해 줌
CREATE INDEX bigemp_annsal_ix
ON bigemp(salary*12);
--인덱스 만들고 난 뒤 월급*12 값 출력해보기..
SELECT* FROM bigemp
WHERE salary*12 > 110000;
DROP INDEX bigemp_annsal_ix;



