-- 과제
SELECT DEPTNO||'번 부서', COUNT(*) FROM EMP GROUP BY DEPTNO
)Q
PIVOT(
COUNT(*) FOR DEPTNO IN (["10번부서"], ["20번부서"], ["30번부서"])
)P

    -- 1.
SELECT 
    (SELECT COUNT(*) FROM EMP WHERE DEPTNO = 10) AS "10번부",
    (SELECT COUNT(*) FROM EMP WHERE DEPTNO = 20) AS "20번부서",
    (SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30) AS "30번부서"
FROM EMP WHERE ROWNUM = 1;

    --2.
SELECT 
    SUM(NVL(DECODE(DEPTNO, 10, COUNT(*)), 0)) AS "10번부서",
    SUM(NVL(DECODE(DEPTNO, 20, COUNT(*)), 0)) AS "20번부서",
    SUM(NVL(DECODE(DEPTNO, 30, COUNT(*)), 0)) AS "30번부서"
FROM EMP
GROUP BY DEPTNO;

    --3.
    
/*
SELECT
    DECODE(DEPTNO, 10, COUNT(*),
                   20, COUNT(*),
                   30, COUNT(*))
FROM EMP;
*/
-- 자습중 연습 
SELECT * FROM TAB;
SELECT * FROM DEPT;
SELECT * FROM BONUS;
SELECT * FROM EMP;
SELECT EMPNO, ENAME FROM EMP;
SELECT EMPNO, ENAME FROM EMP WHERE SAL > 2000;
SELECT EMPNO, ENAME, SAL*12 AS ANNUALSAL FROM EMP;
SELECT ENAME, SAL, COMM FROM EMP;
SELECT ENAME, SAL COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT ENAME, SAL, COMM, SAL+COMM AS TOTAL_SAL FROM EMP;
SELECT ENAME, SAL, COMM, NVL(COMM, 0) + SAL AS TOTAL_SAL FROM EMP;

SELECT * FROM EMP;
SELECT JOB FROM EMP ORDER BY JOB ASC;
SELECT ENAME, JOB FROM EMP ORDER BY ENAME DESC, JOB ASC;

-- 단일행 - 변환함수(TO_CHAR)
SELECT 0012345600,TO_CHAR(00123456,'999999999'),TO_CHAR(00123456,'000000000')FROM DUAL;

-- 그룹행 함수
SELECT    SUM(NVL(COMM,0)) AS SUM_COMM1,SUM(COMM) AS SUM_COMM2, NVL(SUM(COMM),0)AS SUM_COMM3 FROM EMP;

-- GROUP BY
SELECT   DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)    FROM EMP GROUP BY DEPTNO;
SELECT JOB,COUNT(*),AVG(SAL)FROM EMP GROUP BY JOB;

SELECT    DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)    
FROM EMP 
GROUP BY DEPTNO 
ORDER BY DEPTNO;

SELECT COMM,COUNT(*) FROM EMP
GROUP BY COMM;

SELECT    DEPTNO,COUNT(*) AS CNT_DEPT,SUM(SAL) AS SUM_SAL,ROUND(AVG(SAL),0) AS AVG_SAL
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO,SUM_SAL;

-- HAVING
SELECT    DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)    FROM EMP GROUP BY DEPTNO;
SELECT    DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)    FROM EMP GROUP BY DEPTNO      HAVING    SUM(SAL) > 9000;
SELECT    DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)    FROM EMP GROUP BY DEPTNO      HAVING DEPTNO in (10,20);

SELECT DEPTNO,COUNT(*),SUM(SAL),AVG(SAL)   
FROM EMP 
WHERE DEPTNO IN (10,20)
GROUP BY DEPTNO     
HAVING SUM(SAL) > 9000 
ORDER BY SUM(SAL);

SET SERVEROUTPUT ON
EXECUTE SELECTION;

-- SEQUENCE
CREATE SEQUENCE   SCOTT.ORDER_SEQ13
    INCREMENT BY 	1
    START WITH 		1
    MAXVALUE 		999999999999
    MINVALUE 		1
    NOCYCLE 
    CACHE 			30;
    
SELECT ORDER_SEQ13.CURRVAL FROM    DUAL;
SELECT ORDER_SEQ13.NEXTVAL FROM    DUAL;
SELECT ORDER_SEQ13.NEXTVAL FROM    DUAL;
SELECT ORDER_SEQ13.NEXTVAL FROM    DUAL;
SELECT ORDER_SEQ13.CURRVAL FROM    DUAL;
ROLLBACK;
SELECT ORDER_SEQ13.NEXTVAL FROM    DUAL;
SELECT ORDER_SEQ13.NEXTVAL FROM    DUAL;

SELECT EMPNO, ENAME, ORDER_SEQ13.NEXTVAL FROM EMP;

SELECT * FROM TAB;

-- 윤후씨 과제
    -- 요일
    SELECT TO_CHAR(SYSDATE 'DAY', 'NLS_DATE_LANGUAGE = AMERICAN')
    FROM DAUL; -- 이 경우 이 문장에만 영향을 미쳐 보여주는것만 영어로 보여줌 
    
    ALTER SESSION SET NLS_TERRITORY = 'AMERICA'; -- 세션 자체의 언어를 바꿔줌
    
    -- YY, RR
    
    ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
    
    SELECT TO_DATE('51-01-01', 'YY-MM-DD')
    FROM DUAL;
    
    SELECT TO_DATE('52-01-01', 'RR-MM-DD')
    FROM DUAL;
    
    -- PROBLEM
    ALTER SESSION SET NLS_DATE_FORMAT='YY-MM-DD';
    
    SELECT HIREDATE FROM EMP
    WHERE HIREDATE LIKE '82%';
    
    ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY';
    
    --1
    SELECT A.HIREDATE, B.ND
    FROM EMP A,
        (SELECT EMPNO, TO_CHAR(HIREDATE, 'YY-MM-DD') AS ND
        FROM EMP) B
    WHERE A.EMPNO = B.EMPNO
    AND B.ND LIKE '82%';
    
    --2
    SELECT HIREDATE
    FROM EMP
    WHERE TO_CHAR(HIREDATE, 'YY-MM-DD') LIKE '82%'; -- LVALUE를 건드리는것이므로 연산의 과부하가 걸릴수 있다.
                                                    -- 또한, INDEX가 있다면 INDEX를 사용하지 못할수도 있다. 
    
    SELECT HIREDATE FROM EMP WHERE HIREDATE LIKE '%82';
    
    
-- 책 코드
SELECT * FROM EMP;

SELECT  E.ENAME||'"S MANAGER IS '||M.ENAME
FROM    EMP E, EMP M
WHERE   E.MGR = M.EMPNO
ORDER   BY M.ENAME;

SELECT  E.ENAME||'"S MANAGER IS '||NVL(M.ENAME, 'NOBODY')
FROM    EMP E, EMP M
WHERE   E.MGR = M.EMPNO(+)
ORDER   BY M.ENAME;

SELECT  D.DEPTNO, D.DNAME, E.ENAME
FROM    SCOTT.EMP E FULL OUTER JOIN SCOTT.DEPT D
ON      E.DEPTNO = D.DEPTNO
ORDER   BY E.DEPTNO;