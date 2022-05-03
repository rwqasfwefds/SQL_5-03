-- ���� *****(������ ����)
-- ��� ��ȣ�� 7788�� ������ �μ�����? �̰� �˰� ��������
-- ������ ���ٸ� �̷��� 2�� ��ȸ�� �غ��� ���� ����
SELECT DNO
FROM EMPLOYEE
WHERE ENO = 7788;

SELECT DNAME
FROM DEPARTMENT
WHERE DNO = 20;

-- ��� ������ �缺�ҷ��� JOIN�� ���� �ѹ��� �԰���
-- �Ϲ� JOIN(EQUAL JOIN, INNER JOIN) : ������
-- �Ǽ����� ���� ���� �տ� ���� ���� ���� �ڿ��� ������ ����Ʈ�� 4�� ���÷��̴� 14��
SELECT A.DNO, A.DNAME, A.LOC
FROM DEPARTMENT A,
     EMPLOYEE B
WHERE B.DNO = A.DNO -- �����÷��� ã�Ƽ� ������
AND B.ENO = 7788;

-- �� ����(Cartesian Product) : ī��þ� ��(�� �Ǵ� ��� �Ǽ��� �� ���ϱ� ������ ���� �� ����)
-- DEPARTMENT �Ǽ� : 4��
-- EMPLOYEE �Ǽ� : 14��
-- 4 * 14 = 56
SELECT *
FROM DEPARTMENT A,
     EMPLOYEE B;
     
-- Equal Join( = Join)(������ ���� �� Equal Join �� �� 90�� ������ �̰� ��)
-- ���� ��� ���̺��� �����÷��� =(�̲�) �񱳸� ����
-- ���� ���� ������ ���� �����Ͽ� ����� ����
-- ���� ��� �� : �׻� ���� �Ǽ� ���̺��� ���� ó���ǰ� ������ ��
-- ���� : 
-- SELECT ���̺�1.�÷�, ���̺�2.�÷�
-- FROM ���̺�1, ���̺�2
-- WHERE ���̺�2.�÷� = ���̺�1.�÷�

-- ���� 1)
-- �� ������� �Ҽӵ� �μ����� ���
-- COMMISSION�� MANAGER�� NULL�� �ִµ� ��� �� NOT EQUAL�� �� ���ĸ�
-- �����ϴ� �����ü���� NULL�� �����ϱ� (+)�� �� �ᵵ �Ǵ°���
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
ORDER BY D.DNO;

-- ���� 2)
-- �����ȣ�� 7499, 7900�� ������� �Ҽӵ� �μ����� ��� ���
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO AND
E.ENO IN (7499, 7900);

-- ���� 3)
-- �����ȣ�� 7500 ~ 7700���̿� �ִ� ������� �Ҽӵ� �μ����� ��� �ϵ�,
-- �μ� �̸��� SALES�� ��Ʈ�� ����ϼ�
SELECT *
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO 
AND E.ENO BETWEEN 7500 AND 7700 
AND D.DNAME = 'SALES';

-- ���̺� �ּ� �� �÷� �ּ� �ֱ�
-- ���̺� �ּ�
COMMENT ON TABLE DEPARTMENT IS '�μ� ����';
-- �÷� �ּ�
COMMENT ON COLUMN DEPARTMENT.DNAME IS '�μ� �̸�';
COMMENT ON COLUMN DEPARTMENT.DNO IS '�μ� ��ȣ';
COMMENT ON COLUMN DEPARTMENT.LOC IS '���� �̸�';

-- ���̺� �ּ�
COMMENT ON TABLE EMPLOYEE IS '���� ����';
-- �÷� �ּ�
COMMENT ON COLUMN EMPLOYEE.COMMISSION IS '���ʽ�';
COMMENT ON COLUMN EMPLOYEE.DNO IS '�μ� ��ȣ';
COMMENT ON COLUMN EMPLOYEE.ENAME IS '��� �̸�';
COMMENT ON COLUMN EMPLOYEE.ENO IS '��� ��ȣ';
COMMENT ON COLUMN EMPLOYEE.HIREDATE IS '�Ի���';
COMMENT ON COLUMN EMPLOYEE.JOB IS '��å';
COMMENT ON COLUMN EMPLOYEE.MANAGER IS '������';
COMMENT ON COLUMN EMPLOYEE.SALARY IS '����';
-- ���̺� �ּ�
COMMENT ON TABLE BONUS IS '���ʽ� ����';
-- �÷� �ּ�
COMMENT ON COLUMN BONUS.ENAME IS '����̸�';
COMMENT ON COLUMN BONUS.JOB IS '����';
COMMENT ON COLUMN BONUS.SAL IS '����';
COMMENT ON COLUMN BONUS.COMM IS '���ʽ�';
-- ���̺� �ּ�
COMMENT ON TABLE SALGRADE IS '���� ����';
-- �÷� �ּ�
COMMENT ON COLUMN SALGRADE.GRADE IS '���';
COMMENT ON COLUMN SALGRADE.LOSAL IS '���� ����';
COMMENT ON COLUMN SALGRADE.HISAL IS '�ְ� ����';

-- Ư�� ���) NOT EQUAL ����
-- =(EQUAL) ������ �ƴ� ���� ����
-- ���� ���(SALGRAD) ���̺�
-- 1��� : 700 ~ 1200
-- 2��� : 1201 ~ 1400
-- 5��� : 3001 ~ 9999
-- �޿� ����� �������� ����� �޿��� �� ��޿� ���ϴ��� ARABOZA!!
SELECT ENAME, SALARY, GRADE
FROM SALGRADE A,
     EMPLOYEE B
WHERE SALARY BETWEEN LOSAL AND HISAL;

-- ��� �������� �߰� �μ� ���� �����ֱ�
SELECT ENAME, DNAME, SALARY, GRADE
FROM SALGRADE A,
     DEPARTMENT C,
     EMPLOYEE B
WHERE B.DNO = C.DNO
AND SALARY BETWEEN LOSAL AND HISAL;

-- Ư�� ���) SELF ����
-- ������̺� MANAGER �÷�(�� ��� �Ŵ����� ���)
-- �Ŵ����� �̸��� �˱����� ������ 2�������� ã��(��ȿ��)
SELECT ENO, ENAME, MANAGER
FROM EMPLOYEE
WHERE ENAME LIKE 'SMITH%';

SELECT ENO, ENAME
FROM EMPLOYEE
WHERE ENO = 7902;

-- ������ �̷��� �ϸ� ����
SELECT MAN.ENO, 
       MAN.ENAME AS ����, 
       MAN.MANAGER AS "�Ŵ��� �����ȣ",
       EMP.ENAME AS �Ŵ���
FROM EMPLOYEE EMP,
     EMPLOYEE MAN
WHERE  EMP.ENO = MAN.MANAGER
AND MAN.ENAME LIKE 'SMITH%';

-- Ư�����) *** OUTER����
-- = ������ ���� �÷��� �����ؼ� �����͸� �����ִµ� NULL���� = ������ �� �Ǳ� ������ �����Ϳ��� ���� ��
-- NULL���� �ش�Ǵ� �ٸ� �÷��� ������� �� ���� ����
-- �����ϴ� ��� NULL�� ���ԵǾ� ������ NULL���� �ִ� ������ ����� �� ��
-- �׷��� ������� �ؾߵǳ� ��ư �ΰ��� ���ؼ� ���� �ʿ�(+)�� �����ִ°���
-- �� ���� �ϳ��� NULL���� �ִ����� ������ �÷������� ���̰Ա�
SELECT EMP.ENAME AS ����, 
       MAN.ENAME AS �Ŵ���
FROM EMPLOYEE EMP,
     EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.ENO(+);

-- DDL(Data Definition Language) : ������ ���Ǿ�
-- ���̺� �����, ���̺� �����ϱ�, �÷� �����ϱ�, �÷� �߰��ϱ�
-- ���̺� �����
-- ��) �μ������� �����ϱ� ���� ���̺� �����ϱ�
-- ���̺�� : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT(
    DNO NUMBER(2),
    DNAME VARCHAR2(20),
    LOC VARCHAR2(20)
);

-- ���̺� �����ϱ�
DROP TABLE TB_DEPARTMENT;

-- ���̺� �����ϱ�
-- �����ͱ��� ����
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT;

DROP TABLE TB_DEPARTMENT;

-- ������ ���� ���̺� ������ ����
CREATE TABLE TB_DEPARTMENT2
AS
SELECT *
FROM DEPARTMENT
WHERE 1 = 2; -- �Ϻη� �������� ����(�������� ����� ������ �����ð� ���ݽ�����)

DROP TABLE TB_DEPARTMENT2;

-- ����) 20�� �μ� �Ҽ� ����� ���� ������ ������ ���̺� �����ϱ�
-- ���̺� �̸� : TB_DEPARTMENT
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE DNO = 20;

DROP TABLE TB_DEPARTMENT;

-- ���̺� ������ �����ϴ� ��ɾ�
-- ALTER TABLE ~
CREATE TABLE TB_DEPARTMENT
AS
SELECT *
FROM DEPARTMENT
WHERE 1 = 2;

-- TB_DEPARTMENT ���̺� �÷� �߰�
ALTER TABLE TB_DEPARTMENT
ADD(BIRTH DATE);

DESC TB_DEPARTMENT;

-- TB_DEPARTMENT ���̺� �÷� ����
-- DNAME VARCHAR2(14) -> VARCHAR(20) ����
ALTER TABLE TB_DEPARTMENT
MODIFY DNAME VARCHAR2(20);

DESC TB_DEPARTMENT;

-- TB_DEPARTMENT ���̺� �÷� ����
-- BIRTH �÷� ����
ALTER TABLE TB_DEPARTMENT
DROP COLUMN BIRTH;

DESC TB_DEPARTMENT;

-- ���̺� �̸��� �����ϴ� ��ɾ�
-- RENAME A TO B : A���̺� ���� B���̺� ������ �ٲ�
RENAME TB_DEPARTMENT02 TO TB_DEPARTMENT;

-- ���̺��� ��� �����͸� �����ϴ� ��ɾ�(������ + �Ҵ� �� ����(�迭 ����))
-- �׽�Ʈ ������ ����
CREATE TABLE TB_DEPARTMENT02
AS
SELECT *
FROM DEPARTMENT;
-- ������ Ȯ��
SELECT * FROM TB_DEPARTMENT02;

-- ������ ����
TRUNCATE TABLE TB_DEPARTMENT02;
-- ������ Ȯ��
SELECT * FROM TB_DEPARTMENT02;

-- ��ųʸ� : �߰��� ����Ŭ DB���� ����ϴ� 
-- ��Ÿ����(������ ���̺�, �÷�����, �������� ��) �� �� �� �ִ� ���̺�
-- USER_XXX : ���� �� ������ ���� �������� �������� ������(�÷�, ���̺� ��)
-- ALL_XXX : ���� �� ���� + �ٸ� ������ ���� �������� ������(�÷�, ���̺� ��)
-- DBA_XXX : ��� ������ ���� �������� ������(�÷�, ���̺� ��)
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

-- DML(Data Manipulation Language) : ������ ���۾�
-- INSERT / UPDATE / DELETE
-- ���� ������ ���� ���̺� ��� ����
SELECT * FROM USER_TABLES;
-- �ʿ���� ���̺� ����(������������ ��� ���̺�)
DROP TABLE EMP;
DROP TABLE DEPT;

-- �׽�Ʈ�� ���̺� �� ������ �����
CREATE TABLE DEPT_COPY
AS
SELECT * 
FROM DEPARTMENT;
-- ������ �� ���Դ��� Ȯ��
SELECT * FROM DEPT_COPY;

-- ������ ����
TRUNCATE TABLE DEPT_COPY;

-- ������ �߰��ϱ�(���� �ڷ����� �°� ������ �� DNO = ����, DNAME = ����, LOC = ����)
INSERT INTO DEPT_COPY
VALUES(10, 'ACCOUNTING', 'NEW YORK');
-- ���Ͱ��� �̷��� �߰��ϸ� �����δ� ���Ӥ���? �״ϱ� �ӽ�����? �׷� ����, ������ ������ ������
-- ���� Ȯ�� �غ���
SELECT * FROM DEPT_COPY;
-- �׷� ��� �����ݿ��� �ϳ� COMMIT�� �����ָ� ��(COMMIT�� ������ �� �ְ��� ���ָ� ��)
COMMIT;

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(20, 'RESEARCH', 'DALLAS');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(30, 'SALES', 'CHICAGO');

INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(40, 'OPERATIONS', 'BOSTON');

COMMIT;

-- Ȯ��
SELECT * FROM DEPT_COPY;

-- ������ �߰� 
-- LOC�÷��� NULL���� �߰��غ���
-- 1) NULL�� ���� �����ϰ� �߰�
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(50, 'SALES');

SELECT * FROM DEPT_COPY;

-- 2) ��������� NULL�� �߰�(��õ)
INSERT INTO DEPT_COPY
VALUES(60, 'OPERATIONS', NULL);

SELECT * FROM DEPT_COPY;

-- �׽�Ʈ ������ �� EMP_COPY ���̺� �����(������ ������ ���̺�)
CREATE TABLE EMP_COPY
AS
SELECT *
FROM EMPLOYEE
WHERE 1 = 2;

SELECT * FROM EMP_COPY;

-- EMP_COPY ���̺� ������ �ֱ�(DATE���� �׳� ���ڿ��� ��� ����Ŭ ������ TO_DATE() �Լ��� �Ἥ �ڵ� ����ȯ�� ����)
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', SYSDATE, 10);

SELECT * FROM EMP_COPY;

-- �����͸� �߸��־����� ROLLBACK�ϸ� �ǵ�����(�۾����) ����(COMMIT�Ǳ� ������ ���� COMMIT�ǰ� �� �Ŀ��� �� �Ұ���)
ROLLBACK;
-- DB�� ���� �ݿ�
COMMIT;

-- �ٸ� ���̺��� �����͸� �����ؼ� INSERT(�о�ֱ�)�ϱ�
SELECT * FROM DEPT_COPY;
-- �����Ϳ� ���� �� �� ����
TRUNCATE TABLE DEPT_COPY;
-- �ٸ� ���̺��� �����͸� �����ؼ� INSERT(�о�ֱ�)�ϱ�
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;
-- Ȯ��
SELECT * FROM DEPT_COPY;
-- DB�� ���� �ݿ�
COMMIT;

-- DML ��ɾ�
-- ������ �����ϱ� : UPDATE
SELECT * FROM DEPT_COPY;

-- �Ϲ����� ���) UPDATE + WHERE ������
-- �׳� �̷��� �ϸ� DNAME��ü�� PROGRAMMING ��� �ٲ�
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING';

SELECT * FROM DEPT_COPY;

ROLLBACK; -- �������

-- �Ϲ����� ���) UPDATE + WHERE ������
-- ����)
-- UPDATE ���̺��
-- SET �÷��� = ������ ��
-- WHERE ����
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
-- DB ���� �ݿ�
COMMIT;

-- ���� 1) DEPT_COPY ���̺� �μ����� 'SALES'�� �μ��� LOC �÷��� 'BUSAN'���� �����ϼ�
UPDATE DEPT_COPY
SET LOC = 'BUSAN'
WHERE DNAME = 'SALES';

SELECT * FROM DEPT_COPY;

-- ���빮�� 2) DEPT_COPY ���̺� �μ���ȣ�� 20�� �μ��� �μ��̸��� 'JAVA'�� �����ϰ�, LOC�÷��� 'SEOUL'�� �����ϼ�
UPDATE DEPT_COPY
SET DNAME = 'JAVA', 
    LOC = 'SEOUL'
WHERE DNO = 20;

SELECT * FROM DEPT_COPY;

COMMIT;

-- Ư���� ��) DEPT_COPY ���̺��� �μ� ��ȣ�� 10�� LOC �����͸� �����ͼ�
-- �μ� ��ȣ�� 20�� LOC�����ͷ� �����ϱ�
-- ���� �ȿ� ������ ����������� ��(����� ���������� �� �� �Ǹ� ���;� ��)
UPDATE DEPT_COPY
SET LOC = (SELECT LOC FROM DEPT_COPY WHERE DNO = 20)
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;

COMMIT;

-- DML ��ɾ�
-- DELETE : ���̺��� ������ �����ϴ� DML ��ɾ�(COMMIT�� �ؾ� �����ݿ�)
-- ������ ���ΰ� �����͸� ����
-- ���� : 
-- DELETE FROM(��������) ���̺��
-- WHERE ����
DELETE FROM DEPT_COPY
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
COMMIT;

-- ���� 2) DEPT_COPY ���̺��� �μ���ȣ(DNO)�� 20 �Ǵ� 30�� �����͸� �����ϼ�
DELETE DEPT_COPY
WHERE DNO IN(20, 30);

SELECT * FROM DEPT_COPY;
COMMIT;

-- ����) DELETE ~ �������� ��� ����(����� ���������� �� �� �Ǹ� ���;� ��)
DELETE DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPARTMENT WHERE DNAME = 'SALES');






