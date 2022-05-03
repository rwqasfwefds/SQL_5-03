-- 연습문제 9번 : DDL(데이터 정의어) 실습
-- 1) 다음 표에 명시된 대로 DEPT 테이블을 생성하셈
-- 컬럼명 데이터 타입 크기 
-- DNO   NUMBER    2
-- DNAME VARCHAR2  14
-- LOC   VARCHAR2  13
CREATE TABLE DEPT(
    DNO NUMBER(2),
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);

DESC DEPT;

-- 2) 다음 표에 명시된 대로 EMP 테이블을 생성하셈
-- 컬럼명 데이터 타입 크기 
-- ENO   NUMBER    4
-- ENAME VARCHAR2  10
-- DNO   NUMBER   2
CREATE TABLE EMP(
    ENO NUMBER(4),
    ENAME VARCHAR2(10),
    DNO NUMBER(2)
);

DESC EMP;

-- 3) 긴 이름을 저장할 수 있도록 EMP 테이블을 수정하시오
-- ENAME VARCHAR2(10) -> VARCHAR2(25) 수정
ALTER TABLE EMP
MODIFY ENAME VARCHAR2(25);

DESC EMP;

-- 4) EMPLOYEE 테이블을 복사해서 EMPLOYEE2 테이블을 생성하되,
-- 사원번호, 이름, 급여, 부서번호 컬럼만 복사하셈.
CREATE TABLE EMPLOYEE2
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

-- 추가적으로 복사 시 컬럼명을 변경 할 수 있음
-- 순서에 맞게 들어감
CREATE TABLE EMPLOYEE2(ENO_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

DESC EMPLOYEE2;

-- 5) EMP 테이블을 삭제하셈
DROP TABLE EMP;

-- 6) EMPLOYEE2 테이블 이름을 EMP로 변경하셈
RENAME EMPLOYEE2 TO EMP;

-- 7) DEPT 테이블에서 DNAME 컬럼을 제거하셈
ALTER TABLE DEPT
DROP COLUMN DNAME;

DESC DEPT;