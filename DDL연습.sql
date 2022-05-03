-- �������� 9�� : DDL(������ ���Ǿ�) �ǽ�
-- 1) ���� ǥ�� ��õ� ��� DEPT ���̺��� �����ϼ�
-- �÷��� ������ Ÿ�� ũ�� 
-- DNO   NUMBER    2
-- DNAME VARCHAR2  14
-- LOC   VARCHAR2  13
CREATE TABLE DEPT(
    DNO NUMBER(2),
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);

DESC DEPT;

-- 2) ���� ǥ�� ��õ� ��� EMP ���̺��� �����ϼ�
-- �÷��� ������ Ÿ�� ũ�� 
-- ENO   NUMBER    4
-- ENAME VARCHAR2  10
-- DNO   NUMBER   2
CREATE TABLE EMP(
    ENO NUMBER(4),
    ENAME VARCHAR2(10),
    DNO NUMBER(2)
);

DESC EMP;

-- 3) �� �̸��� ������ �� �ֵ��� EMP ���̺��� �����Ͻÿ�
-- ENAME VARCHAR2(10) -> VARCHAR2(25) ����
ALTER TABLE EMP
MODIFY ENAME VARCHAR2(25);

DESC EMP;

-- 4) EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 ���̺��� �����ϵ�,
-- �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϼ�.
CREATE TABLE EMPLOYEE2
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

-- �߰������� ���� �� �÷����� ���� �� �� ����
-- ������ �°� ��
CREATE TABLE EMPLOYEE2(ENO_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, SALARY, DNO
FROM EMPLOYEE;

DESC EMPLOYEE2;

-- 5) EMP ���̺��� �����ϼ�
DROP TABLE EMP;

-- 6) EMPLOYEE2 ���̺� �̸��� EMP�� �����ϼ�
RENAME EMPLOYEE2 TO EMP;

-- 7) DEPT ���̺��� DNAME �÷��� �����ϼ�
ALTER TABLE DEPT
DROP COLUMN DNAME;

DESC DEPT;