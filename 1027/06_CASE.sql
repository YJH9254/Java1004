-- 06_CASE.sql

/*
    # CASE
    
    - DECODE()는 switch-case처럼 정확하게 일치하는 경우만 매핑이 가능하다
    - CASE는 if문처럼 원하는 조건에 따라 원하는 동작을 할 수 있다

SELECT
    CASE
        WHEN 조건1 THEN 출력값1
        WHEN 조건2 THEN 출력값2
        ...
        ELSE 기본값
    END
FROM
*/
SELECT
    first_name,
    job_id,
    CASE
        WHEN job_id = 'IT_PROG' THEN salary * 1.2
        WHEN job_id LIKE '%_CLERK' THEN salary * 1.03
        ELSE salary
    END AS "incread_salary"
FROM
    employees;
    
