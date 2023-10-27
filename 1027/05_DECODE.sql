-- 05_DECODE.sql

/*
    # DECODE
    
    - 자바의 switch-case와 유사한 문법
    - DECODE(column, casel, valuel, case2, value2, ..., default value)
*/
SELECT 
    first_name,
    DECODE(department_id,
        10, '관리부',
        20, '마케팅부',
        30, '구매부',
        40, '인사부',
        60, 'IT',
        department_id
    ) AS department_name
FROM 
    employees;
    
SELECT * FROM departments;

/*
    연습: 직책에 따라 다음과 같이 인상된 급여를 출력해보세요 (이름/급여 출력하기)
        
        IT_PROG : 20%
        SH_CLERK : 5%
        ST_CLERK : 3%
        그 외 : 변동 없음
*/
SELECT
    first_name, 
    salary AS original_salary,
    DECODE(job_id,
        'IT_PROG', salary * 1.2,
        'SH_CLERK', salary * 1.05,
        'ST_CLERK', salary * 1.03,
        salary
        ) AS increased_salary
FROM
    employees;
