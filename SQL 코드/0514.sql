
SELECT * FROM V$STAT;
-- TRANSACTION�� �б��ϰ��� (READ CONSISTENCY)
    -- SESSION 1
/*(1)*/
UPDATE EMP SET SAL = 0 WHERE DEPTNO = 20;

/*(3)*/
SELECT DEPTNO, ENAME, SAL FROM EMP
WHERE DEPTNO = 20;

/*(4)*/
COMMIT;

/*(6) 3�� ����� */

-- SQL SCRIPT �ҷ����� 
@@C:\Users\HP\Documents\�����ͺ��̽�\createTable.sql;

select*from SYSTEM13;

-- ���̺� �ʱ�ȭ
drop table emp;
@@C:\Users\HP\Documents\�����ͺ��̽�\createEmp.sql;
select * from emp;
COMMIT;

-- TRANSACTION�� ROW LEVEL LOCK
    -- SESSION 1
/*(1)*/
UPDATE EMP SET SAL = 9999 WHERE DEPTNO = 10;

/*(4)*/
COMMIT;

-- SELECT * FOR UPDATE (ROW LEVEL LOCK)
-- (1)
SELECT * FROM EMP WHERE DEPTNO = 10 FOR UPDATE[WAIT];
COMMIT;

-- (2)
SELECT * FROM EMP WHERE DEPTNO = 10 FOR UPDATE;
ROLLBACK;

-- (3)
SELECT * FROM EMP WHERE DEPTNO = 10 FOR UPDATE WAIT 10