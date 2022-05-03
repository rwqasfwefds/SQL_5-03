-- 1) = ������ �̿��ؼ� SCOTT ����� �μ���ȣ�� �μ��̸��� ����ϼ�
SELECT D.DNO AS �μ���ȣ, 
       E.ENAME AS ����̸�, 
       D.DNAME AS �μ��̸�
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
AND E.ENAME = 'SCOTT';

-- 2) ��� ����� �̸��� �� ����� �Ҽӵ� �μ��̸��� �������� ����ϼ� 
SELECT E.ENAME AS ����̸�, 
       D.DNAME AS �μ��̸�, 
       D.LOC AS ������
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO;

-- 3) 10�� �μ��� ���ϴ� ����� ���� ���ް� �������� ����ϼ�
SELECT E.DNO AS �μ���ȣ,
       E.ENAME AS ����̸�, 
       E.JOB AS ����, 
       D.LOC AS ������
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
AND E.DNO = 10;

-- 4) Ŀ�̼��� ���� ��� ����� �̸�, �μ��̸�, �������� ����ϼ�
SELECT E.ENAME AS ����̸�, 
       D.DNAME AS �μ��̸�, 
       D.LOC AS ������
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
AND E.COMMISSION > 0;

-- 5) = ���ΰ� ���ϵ�ī��(%)�� ����Ͽ� �̸��� A�� ���Ե� ��� ����� �̸���
-- �μ����� ����ϼ�
SELECT E.ENAME AS ����̸�, 
       D.DNAME AS �μ��̸�
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
AND E.ENAME LIKE '%A%';

-- 6) NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����ϼ�
SELECT E.ENAME AS ����̸�, 
       E.JOB AS ����,
       D.DNO AS �μ���ȣ,
       D.DNAME AS �μ���
FROM DEPARTMENT D,
     EMPLOYEE E
WHERE D.DNO = E.DNO
AND D.LOC = 'NEW YORK';