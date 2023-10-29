-- 03_WHERE.sql

/*
    # SELECT 컬럼명 FROM 테이블명 WHERE 조건절;
    
    - SELECT문 뒤에 WHERE절을 추가하여 해당 조건을 만족하는 행만 조회할 수 있다
    - 오라클의 비교 연산자와 논리 연산자를 통해 조건절을 만들 수 있다
    
    # 비교 연산자
    
    =           : 같으면 true, (==은 안된다)
    !=, <>, ^=  : 다르면 true
    <, >, <=, >= : 비교
    
    # 논리 연산자
    
    AND, OR, NOT
*/
-- 월급이 10000달러 이상인 사원을 모두 조회
SELECT
    *
FROM
    employees
WHERE
    salary >= 10000;
-- 매니저ID가 101번인 사원을 모두 조회
SELECT
    *
FROM
    employees
WHERE
    manager_id = 101;
-- 문자열 데이터는 ''를 사용한다 (""는 AS하고 컬럼 별칭 정할때 사용) 
SELECT
    *
FROM
    employees
WHERE
    last_name = 'Austin';
-- 데이터는 대소문자를 구분한다
SELECT
    *
FROM
    employees
WHERE
    last_name = 'austin';

-- AND를 통해서 연산 할 수 있다
SELECT
    first_name,
    salary,
    department_id
FROM
    employees
WHERE
        department_id = 50
    AND salary < 3000;

-- 데이터베이스에서는 문자 타입도 비교가 가능하다 (사전순 비교)
SELECT
    *
FROM
    employees
WHERE
        first_name >= 'A'
    AND first_name < 'D';

SELECT
    *
FROM
    employees
WHERE
    first_name <= 'Curtis';

-- 날짜 타입 비교
SELECT
    *
FROM
    employees
WHERE
    hire_date > '2007/12/31';

-- 연습1: 월급이 2000에서 3000사이인 사원들의 풀네임, 월급, 직책을 조회해보세요
SELECT first_name || ' ' || last_name AS full_name, salary, job_id
FROM employees
WHERE salary >= 2000 AND salary <= 3000;

-- 연습2: 직책이 SH_CLERK이거나 ST_CLERK인 사원들의 이름, 전화번호를 조회해보세요
SELECT first_name, phone_number FROM employees
WHERE job_id = 'SH_CLERK' OR job_id = 'ST_CLERK';

-- 연습3: 30/60/100번 부서에 속한 사원들의 이름, 고용일을 조회해보세요
SELECT first_name, hire_date FROM employees 
WHERE department_id = 30 OR department_id = 60 OR department_id = 100;

-- 연습4: 월급이 5000$ 이하인 사원이 있는 직책은 어떤것이 있는지 조회해보세요
SELECT DISTINCT job_id FROM employees WHERE salary <= 5000;

-- 컬럼명 BETWEEN A AND B : 해당 컬럼 값이 A와 B사이인 경우 true
SELECT first_name, salary FROM employees WHERE salary BETWEEN 2000 AND 3000;

-- 컬럼명 IN (A,B,C,...) : ()안의 내용에 해당 값이 있으면 true
SELECT first_name, job_id FROM employees WHERE job_id IN ('SH_CLERK', 'ST_CLERK');
SELECT first_name, department_id
    FROM employees WHERE department_id IN (30, 60, 100);
    
-- () 안의 값을 나열하는 장소에 다른 쿼리문을 활용해 값을 나열할 수 있다 (서브 쿼리)
SELECT first_name, department_id 
    FROM employees WHERE department_id IN ( 
        SELECT department_id FROM departments WHERE location_id = 1700);
    
-- null은 크기 비교가 불가능하기 때문에 일반적인 비교 연산자를 사용하면 모두 false이다
SELECT * FROM employees WHERE commission_pct = null;

-- null인 행들을 조회하고 싶을 때
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE nvl(commission_pct, 0) = 0;

-- null이 아닌 행들을 조회하고 싶을 때
SELECT * FROM employees WHERE NOT commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

-- 사원번호가 홀수인 사원들만 조회해보기 
-- (% 대신 mod(value, divider) 함수를 사용해 나머지를 구할 수 있다)
SELECT * FROM employees WHERE mod(employee_id, 2) = 1;

/*
    # Like
    
    - 데이터의 일부분이 일치하는 행을 조회할 수 있다
    - % : 문자가 있어도 되고 없어도 되는 자리 (정규표현식 *와 유사)
    - _ : 반드시 한 글자가 있어야 하는 자리
*/
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'S%';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '_t%';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '_l%';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '__l';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%r';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%e_';

SELECT hire_date FROM employees WHERE hire_date LIKE '%/02/%';
SELECT hire_date FROM employees WHERE hire_date LIKE '%/%/20';

-- 연습1: first_name에 a, A가 구분없이 포함된 모든 사원들의 이름을 조회
SELECT first_name || ' ' || last_name AS full_name FROM employees 
    WHERE first_name LIKE '%a%' OR first_name LIKE '%A%';
    
-- 연습2: first_name에 e, E가 구분없이 포함된 2개 포함된 모든 사원들의 이름을 조회
SELECT first_name FROM employees 
    WHERE first_name LIKE '%e%e%' OR first_name LIKE 'E%e%';

-- 연습3: first_name이 다섯 글자이면서 r로 끝나는 모든 사원들의 이름을 조회
SELECT first_name FROM employees WHERE first_name LIKE '____r';

-- 연습4: 8월에 입사한 사원들의 이름과 고용일 조회
SELECT first_name, hire_date FROM employees 
    WHERE hire_date LIKE '%/08%';
