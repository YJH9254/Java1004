-- 13_서브 쿼리.sql

/*
    # 서브 쿼리
    
    - 쿼리문 내부에 포함된 또 다른 쿼리문
    - 서브 쿼리를 포함하고 있는 쿼리는 메인 쿼리라고 부른다
    - 서브 쿼리의 실행 결과가 한 줄인지 여러 줄인지에 따라 단일 행 서브쿼리와
      다중 행 서브쿼리로 분류된다
    - 단일 행의 결과를 원한다면 주로 기본키를 사용하여 한 행을 조회한다
    - 단일 행 서브쿼리를 대상으로 하는 연산자와 
      다중 행 서브쿼리를 대상으로하는 연산자가 나뉘어져 있다
    - 서브 쿼리의 결과는 비교해야 하는 대상으로 사용되거나 테이블 대용으로 활용될 수 있다
    
    # 단일 행 서브 쿼리
    
    - 서브 쿼리의 실행 결과가 단 한 줄인 경우
    - 단일행 서브쿼리 연산자 (=, >, <, <>, ^=, >=, ...)
    
    # 다중 행 서브 쿼리
    
    - 서브 쿼리의 실행 결과가 2행 이상일 수 있는 경우
    - 다중행 서브쿼리 연산자 (IN, ANY, SOME, ALL, EXISTS ...)
*/

-- 1. 비교값 대신 서브쿼리 활용하기
SELECT * FROM employees 
WHERE salary >= (SELECT salary FROM employees WHERE employee_id = 169);

-- 서브 쿼리의 결과가 여러 줄이 나오는 경우 일반 연산자는 사용할 수 없다
SELECT * FROM employees 
WHERE salary >= (SELECT salary FROM employees WHERE first_name = 'Alexander');

-- 2. 조회해야 할 테이블 대신 서브쿼리 사용하기
SELECT * FROM (SELECT first_name, job_id FROM employees WHERE job_id = 'IT_PROG');

/*
    # 다중 행 서브 쿼리 연산자
    
    - IN     : 여러 값들 중 일치하는 것이 하나라도 있으면 true
    - ANY    : 여러 값들 중 조건을 만족시키는 것이 하나라도 있으면 true
    - SOME   : ANY랑 같음
    - ALL    : 여러 값들이 조건을 모두 만족시키는 경우에만 true
    - EXISTS : 값이 하나라도 조회되면 true
*/

-- IN

-- ex: Alexander라는 사람이 속해있는 직책을 가지고 있는 모든 사원을 조회
SELECT * FROM employees 
WHERE job_id IN (SELECT job_id FROM employees WHERE first_name = 'Alexander');

-- ANY, SOME
SELECT * FROM employees WHERE salary >= ANY(5000, 8000, 9000, 15000);
SELECT * FROM employees WHERE salary = SOME(5000, 8000, 9000, 15000);

-- ex: 60번 부서 사람들 중 가장 못버는 사람보다 많이 버는 직원을 조회
SELECT * FROM employees 
WHERE salary > ANY(SELECT salary FROM employees WHERE department_id = 60);

SELECT * FROM employees WHERE department_id = 60;


-- ALL
SELECT * FROM employees WHERE salary > ALL(5000, 6000, 7000, 8000, 9000);

-- ex: 60번 부서의 모든 사원들보다 더 잘버는 사원만 조회
SELECT * FROM employees 
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id = 60);


-- EXISTS

-- ex: 최대 급여를 받는 사원이 있는 부서를 조회
SELECT department_name FROM departments d 
WHERE EXISTS (SELECT
    *
FROM
         employees e
    INNER JOIN jobs j ON e.job_id = j.job_id
WHERE
    e.salary = j.max_salary AND e.department_id = d.department_id);


-- 연습1: job_title에 Manager가 포함되는 사원들의 전화번호와 이메일을 조회해보세요 
SELECT * FROM employees WHERE job_id IN 
(SELECT job_id FROM jobs WHERE job_title LIKE '%Manager%')
ORDER BY employee_id;


-- 연습2: 고용일이 2007년인 사원들이 소속한 부서에서 가장 돈을 많이버는 사원들을 조회해보세요 
SELECT * FROM employees WHERE (salary, department_id) 
IN (SELECT max(salary), department_id FROM employees 
WHERE department_id IN 
(SELECT DISTINCT department_id FROM employees WHERE hire_date LIKE '07/%')
GROUP BY department_id) ORDER BY employee_id;



-- 서브 쿼리로 2열 이상을 한번에 비교하는 방법 (다중 열 서브쿼리)
SELECT * FROM employees WHERE 
(first_name, last_name) IN (('Steven', 'King'), ('Neena', 'Kochhar'));


