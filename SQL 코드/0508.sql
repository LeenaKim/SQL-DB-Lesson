
-- 단일행 문자열 함수
SELECT ENAME,lower(ENAME),upper(ENAME),initcap(ENAME) FROM EMP;
SELECT ENAME,substr(ENAME,1,3),substr(ENAME,4),substr(ENAME,-3,2) FROM EMP;
SELECT ENAME,instr(ENAME,'A'),instr(ENAME,'A',2),instr(ENAME,'A',1,1) FROM EMP;
SELECT ENAME,rpad(ENAME,10,'*'),lpad(ENAME,10,'+') FROM EMP;
SELECT rpad(ENAME,10,' ')||' ''sJOB is '||lpad(JOB,10,' ') as JOB_list FROM EMP;
SELECT ENAME,REPLACE(ENAME,'S','s') FROM EMP;
SELECT ENAME, concat(ENAME,JOB), ENAME||JOB FROM EMP;
SELECT ltrim(' 대한민국'), rtrim(' 대한민국'), trim(' 대한민국') FROM dual;
SELECT trim('장' FROM '장발장'), ltrim('장발장','장'), rtrim('장발장','장') FROM dual;
SELECT length('abcd'), substr('abcd',2,2), length('대한민국'), substr('대한민국',2,2) FROM dual;
SELECT lengthb('abcd'), substrb('abcd',2,2), lengthb('대한민국'), substrb('대한민국',2,2) FROM dual;
SELECT length('abcd'),vsize('abcd'), length('대한민국'), vsize('대한민국') FROM dual;

-- 단일행 - 숫자함수
SELECT round(45.923,2),round(45.923,1),round(45.923,0),round(45.923),round(45.923,-1)FROM dual;
SELECT trunc(45.923,2), trunc(45.923,1), trunc(45.923,0), trunc(45.923), trunc(45.923,-1) FROM   dual;
SELECT mod(100,3), mod(100,2) FROM dual;
SELECT ENAME,SAL,SAL*0.053 as tax,round(SAL*0.053,0) as r_tax FROM EMP;--급여의5.3%세금,원단위
SELECT CEIL(-45.594), CEIL(-45.294),CEIL(45.294),ROUND(-45.594),ROUND(-45.294),ROUND(45.594) FROM DUAL; 
SELECT FLOOR(45.245),FLOOR(-45.245),FLOOR(45.545),FLOOR(-45.545) FROM DUAL;

-- date type 실습
SELECT sysdate, sysdate + 7, sysdate - 2, sysdate + 1/24 FROM dual;
SELECT deptno,ename, trunc(sysdate - hiredate) as work_day FROM emp ORDER BY deptno,work_day DESC;
SELECT ename,to_char(sysdate,'YYYY-MM-DD:HH24:MI:SS'),to_char(hiredate,'YYYY-MM-DD:HH24:MI:SS')FROM emp;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
SELECT ename,sysdate,hiredate FROM emp;   
SELECT SYSDATE FROM DUAL;

-- 단일행 - 날짜함수
SELECT hiredate, months_between (sysdate, hiredate), months_between(hiredate, sysdate) FROM EMP;
SELECT sysdate,add_months(sysdate,3),add_months(sysdate,-1) FROM dual;
SELECT sysdate, last_day(sysdate), next_day(sysdate,'일요일'), next_day(sysdate,1),next_day(sysdate,2) FROM DUAL;
SELECT sysdate+75,round(sysdate+75,'YEAR'),round(sysdate+75,'MONTH'),round(sysdate+75,'DAY'),round(sysdate+75) FROM dual;
SELECT sysdate+75,trunc(sysdate+75,'YEAR'),trunc(sysdate+75,'MONTH'),trunc(sysdate+75,'DAY'),trunc(sysdate+75)FROM dual;
SELECT to_char(sysdate,'MM"월"DD"일"') as mmdd1,to_char(sysdate,'MM')||'월'||to_char(sysdate,'DD')||'일' as mmdd2 FROM dual;
SELECT EXTRACT(YEAR FROM SYSDATE),EXTRACT(MONTH FROM SYSDATE),EXTRACT(DAY FROM SYSDATE)FROM DUAL;
SELECT HIREDATE, EXTRACT(YEAR FROM HIREDATE) FROM EMP;
SELECT TO_DATE(EXTRACT(YEAR FROM SYSDATE));


-- 단일행 - 변환함수(TO_CHAR)
SELECT SYSDATE,TO_CHAR(SYSDATE,'YEAR'),TO_CHAR(SYSDATE,'Year'),TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(SYSDATE,'YY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MONTH'),TO_CHAR(SYSDATE,'MON'),TO_CHAR(SYSDATE,'Mon'),TO_CHAR(SYSDATE,'mon'),TO_CHAR(SYSDATE,'MM'),TO_CHAR(SYSDATE,'mm')FROM DUAL;
SELECT SYSDATE,TO_CHAR(SYSDATE,'DAY'), TO_CHAR(SYSDATE,'Day'),TO_CHAR(SYSDATE,'DY'),TO_CHAR(SYSDATE,'dy'),TO_CHAR(SYSDATE,'DD'),TO_CHAR(SYSDATE,'dd')FROM DUAL;
SELECT 123456, TO_CHAR(123456,'999999'),
    LENGTH(TO_CHAR(123456,'999999')),
    LENGTH(TO_CHAR(123456,'fm999999'))
FROM DUAL;
SELECT TO_CHAR(12345*123.45,'999,999.99'),TO_CHAR(12345*123.45,'99,999,999.99') FROM DUAL;  
SELECT TO_CHAR(SAL,'$999,999'), REPLACE(TO_CHAR(SAL,'$999,999'),' ','?'), TO_CHAR(SAL,'L999,999'), TO_CHAR(SAL,'999,999L'),TO_CHAR(SAL,'fm999,999L')FROM EMP;

-- 그룹행 함수
SELECT MIN(ENAME),MAX(ENAME),MIN(SAL),MAX(SAL),MIN(HIREDATE),MAX(HIREDATE)FROM EMP;
SELECT COUNT(*),COUNT(EMPNO),COUNT(MGR),COUNT(COMM)FROM EMP;
SELECT COUNT(JOB),COUNT(ALL JOB),COUNT(DISTINCT JOB),SUM(SAL),SUM(DISTINCT SAL)FROM EMP;
SELECT COUNT(*), SUM(COMM),SUM(COMM)/COUNT(*),AVG(COMM),SUM(COMM)/COUNT(COMM)FROM EMP;
SELECT SAL,COMM FROM EMP;
SELECT SUM(NVL(COMM,0)) AS SUM_COMM1,SUM(COMM) AS SUM_COMM2, NVL(SUM(COMM),0)AS SUM_COMM3 FROM EMP;

-- 과제
SELECT TO_CHAR(SYSDATE, 'HH'), TO_CHAR(SYSDATE, 'HH12'), TO_CHAR(SYSDATE, 'HH24') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'SSSSS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DDD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'Y') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DDD'),TO_CHAR(SYSDATE,'DD'),TO_CHAR(SYSDATE,'D')FROM DUAL;
SELECT LAST_DAY(SYSDATE) FROM DUAL;