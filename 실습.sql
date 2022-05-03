-- 조인 *****(교집합 개념)
-- 사원 번호가 7788인 직원의 부서명은? 이걸 알고 싶은거임
-- 조인이 없다면 이렇게 2번 조회를 해봐야 겠지 ㅇㅇ
SELECT DNO
FROM EMPLOYEE
WHERE ENO = 7788;

SELECT DNAME
FROM DEPARTMENT
WHERE DNO = 20;

-- 상기 목적을 당성할려면 JOIN을 쓰면 한번에 쌉가능
-- 일반 JOIN(EQUAL JOIN, INNER JOIN) : 교집합
-- 건수수가 작은 놈을 앞에 적고 많은 놈을 뒤에다 적으셈 디팔트는 4개 임플로이는 14개
SELECT A.DNO, A.DNAME, A.LOC
FROM DEPARTMENT A,
     EMPLOYEE B
WHERE B.DNO = A.DNO -- 공통컬럼을 찾아서 조인함
AND B.ENO = 7788;

-- 곱 조인(Cartesian Product) : 카디시안 곱(한 건당 모든 건수를 다 곱하기 때문에 성능 씹 ㅈ망)
-- DEPARTMENT 건수 : 4건
-- EMPLOYEE 건수 : 14건
-- 4 * 14 = 56
SELECT *
FROM DEPARTMENT A,
     EMPLOYEE B;
     
-- Equal Join( = Join)(조인은 거의 다 Equal Join 임 걍 90퍼 정도가 이거 씀)
-- 조인 대상 테이블에서 공통컬럼을 =(이꼴) 비교를 통해
-- 같은 값을 가지는 행을 연결하여 결과를 생성
-- 성능 향상 팁 : 항상 작은 건수 테이블이 먼저 처리되게 만들어야 함
-- 문법 : 
-- SELECT 테이블1.컬럼, 테이블2.컬럼
-- FROM 테이블1, 테이블2
-- WHERE 테이블2.컬럼 = 테이블1.컬럼

-- 문제 1)
-- 각 사원들이 소속된 부서정보 얻기
-- COMMISSION과 MANAGER에 NULL이 있는데 얘는 왜 NOT EQUAL를 안 쓰냐면
-- 조인하는 대상자체에는 NULL이 없으니깐 (+)를 안 써도 되는거임
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
ORDER BY D.DNO;

-- 문제 2)
-- 사원번호가 7499, 7900인 사원들의 소속된 부서정보 모두 출력
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO AND
E.ENO IN (7499, 7900);

-- 문제 3)
-- 사원번호가 7500 ~ 7700사이에 있는 사원들의 소속된 부서정보 출력 하되,
-- 부서 이름이 SALES인 파트만 출력하셈
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO 
AND E.ENO BETWEEN 7500 AND 7700 
AND D.DNAME = 'SALES';

-- 테이블 주석 및 컬럼 주석 넣기
-- 테이블 주석
COMMENT ON TABLE DEPARTMENT IS '부서 정보';
-- 컬럼 주석
COMMENT ON COLUMN DEPARTMENT.DNAME IS '부서 이름';
COMMENT ON COLUMN DEPARTMENT.DNO IS '부서 번호';
COMMENT ON COLUMN DEPARTMENT.LOC IS '지역 이름';

-- 테이블 주석
COMMENT ON TABLE EMPLOYEE IS '직원 정보';
-- 컬럼 주석
COMMENT ON COLUMN EMPLOYEE.COMMISSION IS '보너스';
COMMENT ON COLUMN EMPLOYEE.DNO IS '부서 번호';
COMMENT ON COLUMN EMPLOYEE.ENAME IS '사원 이름';
COMMENT ON COLUMN EMPLOYEE.ENO IS '사원 번호';
COMMENT ON COLUMN EMPLOYEE.HIREDATE IS '입사일';
COMMENT ON COLUMN EMPLOYEE.JOB IS '직책';
COMMENT ON COLUMN EMPLOYEE.MANAGER IS '관리자';
COMMENT ON COLUMN EMPLOYEE.SALARY IS '월급';
-- 테이블 주석
COMMENT ON TABLE BONUS IS '보너스 정보';
-- 컬럼 주석
COMMENT ON COLUMN BONUS.ENAME IS '사원이름';
COMMENT ON COLUMN BONUS.JOB IS '직급';
COMMENT ON COLUMN BONUS.SAL IS '월급';
COMMENT ON COLUMN BONUS.COMM IS '보너스';
-- 테이블 주석
COMMENT ON TABLE SALGRADE IS '월급 정보';
-- 컬럼 주석
COMMENT ON COLUMN SALGRADE.GRADE IS '등급';
COMMENT ON COLUMN SALGRADE.LOSAL IS '최저 월급';
COMMENT ON COLUMN SALGRADE.HISAL IS '최고 월급';

-- 특수 용례) NOT EQUAL 조인
-- =(EQUAL) 조인이 아닌 범위 조인
-- 월급 등급(SALGRAD) 테이블
-- 1등급 : 700 ~ 1200
-- 2등급 : 1201 ~ 1400
-- 5등급 : 3001 ~ 9999
-- 급여 등급을 기준으로 사원의 급여가 몇 등급에 속하는지 ARABOZA!!
SELECT ENAME, SALARY, GRADE
FROM SALGRADE A,
     EMPLOYEE B
WHERE SALARY BETWEEN LOSAL AND HISAL;

-- 상기 예제에서 추가 부서 정보 보여주기
SELECT ENAME, DNAME, SALARY, GRADE
FROM SALGRADE A,
     DEPARTMENT C,
     EMPLOYEE B
WHERE B.DNO = C.DNO
AND SALARY BETWEEN LOSAL AND HISAL;

-- 특수 용례) SELF 조인
-- 사원테이블에 MANAGER 컬럼(그 사원 매니저의 사번)
-- 매니저의 이름을 알기위해 쿼리를 2번날려서 찾음(비효율)
SELECT ENO, ENAME, MANAGER
FROM EMPLOYEE
WHERE ENAME LIKE 'SMITH%';

SELECT ENO, ENAME
FROM EMPLOYEE
WHERE ENO = 7902;

-- 위에걸 이렇게 하면 간편
SELECT MAN.ENO, 
       MAN.ENAME AS 직원, 
       MAN.MANAGER AS "매니저 사원번호",
       EMP.ENAME AS 매니저
FROM EMPLOYEE EMP,
     EMPLOYEE MAN
WHERE  EMP.ENO = MAN.MANAGER
AND MAN.ENAME LIKE 'SMITH%';

-- 특수용례) *** OUTER조인
-- = 조인은 공통 컬럼을 연결해서 데이터를 보여주는데 NULL값은 = 연산이 안 되기 때문에 데이터에서 제외 됨
-- NULL값에 해당되는 다른 컬럼을 보여줘야 될 때도 있음
-- 조인하는 대상에 NULL이 포함되어 있으면 NULL값이 있는 라인은 출력을 못 함
-- 그래서 갯수라고 해야되나 여튼 두개를 비교해서 작은 쪽에(+)로 펼쳐주는거임
-- 두 개중 하나가 NULL값이 있더래도 나머지 컬럼정보는 보이게금
SELECT EMP.ENAME AS 직원, 
       MAN.ENAME AS 매니저
FROM EMPLOYEE EMP,
     EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.ENO(+);

-- DDL(Data Definition Language) : 데이터 정의어
-- 테이블 만들기, 테이블 수정하기, 컬럼 수정하기, 컬럼 추가하기
-- 테이블 만들기
-- 예) 부서정보를 저장하기 위한 테이블 생성하기
-- 테이블명 : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT(
    DNO NUMBER(2),
    DNAME VARCHAR2(20),
    LOC VARCHAR2(20)
);

-- 테이블 삭제하기
DROP TABLE TB_DEPARTMENT;

-- 테이블 복사하기
-- 데이터까지 복사
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT;

DROP TABLE TB_DEPARTMENT;

-- 데이터 빼고 테이블 구조만 복사
CREATE TABLE TB_DEPARTMENT2
AS
SELECT *
FROM DEPARTMENT
WHERE 1 = 2; -- 일부러 거짓으로 만듦(거짓으로 만들면 데이터 가져올게 없잖슴ㅇㅇ)

DROP TABLE TB_DEPARTMENT2;

-- 문제) 20번 부서 소속 사원에 대한 정보를 포함한 테이블 생성하기
-- 테이블 이름 : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE DNO = 20;

DROP TABLE TB_DEPARTMENT;

-- 테이블 구조를 변경하는 명령어
-- ALTER TABLE ~
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE 1 = 2;

-- TB_DEPARTMENT 테이블에 컬럼 추가
ALTER TABLE TB_DEPARTMENT
ADD(BIRTH DATE);

DESC TB_DEPARTMENT;

-- TB_DEPARTMENT 테이블에 컬럼 변경
-- DNAME VARCHAR2(14) -> VARCHAR(20) 변경
ALTER TABLE TB_DEPARTMENT
MODIFY DNAME VARCHAR2(20);

DESC TB_DEPARTMENT;

-- TB_DEPARTMENT 테이블에 컬럼 삭제
-- BIRTH 컬럼 삭제
ALTER TABLE TB_DEPARTMENT
DROP COLUMN BIRTH;

DESC TB_DEPARTMENT;

-- 테이블 이름을 변경하는 명령어
-- RENAME A TO B : A테이블 명을 B테이블 명으로 바꿈
RENAME TB_DEPARTMENT02 TO TB_DEPARTMENT;

-- 테이블의 모든 데이터를 제거하는 명령어(데이터 + 할당 된 공간(배열 생각))
-- 테스트 데이터 생성
CREATE TABLE TB_DEPARTMENT02
AS
SELECT *
FROM DEPARTMENT;
-- 데이터 확인
SELECT * FROM TB_DEPARTMENT02;

-- 데이터 삭제
TRUNCATE TABLE TB_DEPARTMENT02;
-- 데이터 확인
SELECT * FROM TB_DEPARTMENT02;

-- 딕셔너리 : 추가로 오라클 DB에서 사용하는 
-- 메타정보(생성된 테이블, 컬럼정보, 유저정보 등) 를 볼 수 있는 테이블
-- USER_XXX : 접속 된 유저에 대한 여러가지 정보들을 보여줌(컬럼, 테이블 등)
-- ALL_XXX : 접속 된 유저 + 다른 유저에 대한 정보들을 보여줌(컬럼, 테이블 등)
-- DBA_XXX : 모든 유저에 대한 정보들을 보여줌(컬럼, 테이블 등)
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

-- DML(Data Manipulation Language) : 데이터 조작어
-- INSERT / UPDATE / DELETE
-- 현재 유저에 속한 테이블 목록 보기
SELECT * FROM USER_TABLES;
-- 필요없는 테이블 삭제(연습문제에서 썼던 테이블)
DROP TABLE EMP;
DROP TABLE DEPT;

-- 테스트용 테이블 및 데이터 만들기
CREATE TABLE DEPT_COPY
AS
SELECT * 
FROM DEPARTMENT;
-- 데이터 잘 들어왔는지 확인
SELECT * FROM DEPT_COPY;

-- 데이터 삭제
TRUNCATE TABLE DEPT_COPY;

-- 데이터 추가하기(각각 자료형에 맞게 넣으면 됨 DNO = 숫자, DNAME = 문자, LOC = 문자)
INSERT INTO DEPT_COPY
VALUES(10, 'ACCOUNTING', 'NEW YORK');
-- 위와같이 이렇게 추가하면 눈으로는 보임ㅇㅋ? 그니깐 임시저장? 그런 개념, 접속을 끊으면 없어짐
-- 직접 확인 해보셈
SELECT * FROM DEPT_COPY;
-- 그럼 어떻게 영구반영을 하냐 COMMIT를 적어주면 됨(COMMIT는 넣을거 다 넣고나서 해주면 됨)
COMMIT;

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(20, 'RESEARCH', 'DALLAS');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(30, 'SALES', 'CHICAGO');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(40, 'OPERATIONS', 'BOSTON');

COMMIT;

-- 확인
SELECT * FROM DEPT_COPY;

-- 데이터 추가 
-- LOC컬럼에 NULL값을 추가해보자
-- 1) NULL인 값은 생략하고 추가
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(50, 'SALES');

SELECT * FROM DEPT_COPY;

-- 2) 명시적으로 NULL을 추가(추천)
INSERT INTO DEPT_COPY
VALUES(60, 'OPERATIONS', NULL);

SELECT * FROM DEPT_COPY;

-- 테스트 데이터 및 EMP_COPY 테이블 만들기(구조만 복사한 테이블)
CREATE TABLE EMP_COPY
AS
SELECT *
FROM EMPLOYEE
WHERE 1 = 2;

SELECT * FROM EMP_COPY;

-- EMP_COPY 테이블에 데이터 넣기(DATE형은 그냥 문자열로 적어도 오라클 내에서 TO_DATE() 함수를 써서 자동 형변환을 해줌)
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', SYSDATE, 10);

SELECT * FROM EMP_COPY;

-- 데이터를 잘못넣었을때 ROLLBACK하면 되돌리기(작업취소) 해줌(COMMIT되기 전에만 가능 COMMIT되고 난 후에는 쌉 불가능)
ROLLBACK;
-- DB에 영구 반영
COMMIT;

-- 다른 테이블의 데이터를 복사해서 INSERT(밀어넣기)하기
SELECT * FROM DEPT_COPY;
-- 데이터와 공간 둘 다 삭제
TRUNCATE TABLE DEPT_COPY;
-- 다른 테이블의 데이터를 복사해서 INSERT(밀어넣기)하기
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;
-- 확인
SELECT * FROM DEPT_COPY;
-- DB에 영구 반영
COMMIT;

-- DML 명령어
-- 데이터 수정하기 : UPDATE
SELECT * FROM DEPT_COPY;

-- 일반적인 사용) UPDATE + WHERE 조건절
-- 그냥 이렇게 하면 DNAME전체가 PROGRAMMING 얘로 바뀜
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING';

SELECT * FROM DEPT_COPY;

ROLLBACK; -- 실행취소

-- 일반적인 사용) UPDATE + WHERE 조건절
-- 문법)
-- UPDATE 테이블명
-- SET 컬럼명 = 수정할 값
-- WHERE 조건
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
-- DB 영구 반영
COMMIT;

-- 문제 1) DEPT_COPY 테이블에 부서명이 'SALES'인 부서만 LOC 컬럼을 'BUSAN'으로 수정하셈
UPDATE DEPT_COPY
SET LOC = 'BUSAN'
WHERE DNAME = 'SALES';

SELECT * FROM DEPT_COPY;

-- 응용문제 2) DEPT_COPY 테이블에 부서번호가 20인 부서만 부서이름을 'JAVA'로 수정하고, LOC컬럼을 'SEOUL'로 수정하셈
UPDATE DEPT_COPY
SET DNAME = 'JAVA', 
    LOC = 'SEOUL'
WHERE DNO = 20;

SELECT * FROM DEPT_COPY;

COMMIT;

-- 특이한 예) DEPT_COPY 테이블에서 부서 번호가 10인 LOC 데이터를 가져와서
-- 부서 번호가 20인 LOC데이터로 수정하기
-- 쿼리 안에 쿼리를 서브쿼리라고 함(참고로 서브쿼리가 딱 한 건만 나와야 함)
UPDATE DEPT_COPY
SET LOC = (SELECT LOC FROM DEPT_COPY WHERE DNO = 20)
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;

COMMIT;

-- DML 명령어
-- DELETE : 테이블의 내용을 삭제하는 DML 명령어(COMMIT을 해야 영구반영)
-- 공간은 놔두고 데이터만 날림
-- 문법 : 
-- DELETE FROM(생략가능) 테이블명
-- WHERE 조건
DELETE FROM DEPT_COPY
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
COMMIT;

-- 문제 2) DEPT_COPY 테이블에서 부서번호(DNO)가 20 또는 30인 데이터를 삭제하셈
DELETE DEPT_COPY
WHERE DNO IN(20, 30);

SELECT * FROM DEPT_COPY;
COMMIT;

-- 참고) DELETE ~ 서브쿼리 사용 가능(참고로 서브쿼리가 딱 한 건만 나와야 함)
DELETE DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'SALES');






