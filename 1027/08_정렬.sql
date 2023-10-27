-- 08_정렬.sql

/*
    # ORDER BY 컬럼명 [ASC|DESC]
    
    - 조회시 원하는 컬럼 기준으로 정렬하여 조회하는 문법
    - ASC : 오름차순 (Ascending)
    - DESC : 내림차순 (Descending)
    - 입력을 하지 않으면 기본적으로 ASC로 정렬한다
*/
SELECT * FROM employees ORDER BY first_name;
SELECT * FROM employees ORDER BY first_name DESC;
SELECT * FROM employees ORDER BY phone_number ASC;

-- 오름차순서 null은 가장 나중에 등장한다
SELECT first_name, job_id, commission_pct FROM employees
ORDER BY commission_pct ASC;

-- 내림차순시 null은 가장 먼저 등장한다
SELECT first_name, job_id, commission_pct FROM employees
ORDER BY commission_pct DESC;

-- 정렬 기준은 여러개 설정할 수 있다
SELECT * FROM employees ORDER BY department_id ASC, last_name ASC, first_name ASC;

-- ex: 부서번호로 정렬하고, 부서번호가 같으면 성 기준으로 정렬하고,
-- 성도 같으면 이름을 기준으로 정렬한다
SELECT * FROM employees
ORDER BY department_id ASC, last_name ASC, first_name ASC;

SELECT * FROM employees
ORDER BY department_id, last_name, first_name, salary DESC;

-- 연습1: 이름에 i가 포함되어 있는 사원들을 월급 많이 받는 순으로 조회

-- upper(column) : 값을 모두 대문자로 변경
-- lower(column) : 값을 모두 소문자로 변경
SELECT first_name, salary FROM employees WHERE lower(first_name) LIKE '%i%';
ORDER BY salary DESC;

-- 연습2: 모든 사원들을 성 기준으로 오름차순 정렬하고
--       성이 같은 경우 이름 기준으로 오름차순 정렬하여 조회
SELECT * FROM employees ORDER BY last_name ASC, first_name ASC;

-- 연습3: 각 부서의 평균 월급, 사원 수를 조회하고 평균 월급으로 내림차순 정렬하여 조회
SELECT 
    department_id            AS "부서 번호" , 
    round(avg(SALARY), 2)    AS "평균 월급", 
    COUNT(*)                 AS "사원 수" 
FROM 
    employees 
GROUP BY 
    department_id 
ORDER BY 
    "평균 월급" DESC;

/*
    # 소수점 자르는 함수들
    
    - ceil(value)       : 정수로 올림
    - floor(value)      : 정수로 내림
    - round(value, num) : 소수점 반올림하기
    - trunc(value, num) : 소수점 자르기
*/
