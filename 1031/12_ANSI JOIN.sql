-- 12_ANSI JOIN.sql

/*
    # ANSI JOIN
    
    - ANSI에서 지정한 표준 JOIN 문법
    - 다른 RDBMS에서도 사용할 수 있는 공통의 문법
    
    ※ ANSI : America National Standard Institute, 미국 국제 표준 기구
*/

-- CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

/*
    # INNER JOIN (조인 조건을 충족하는 행만 등장하는 조인)
    
    - 조인 조건에는 ON절을 사용하고 다른 조건에는 where절을 사용할 수 있다
    - 조인하는 두 테이블을 연결하기 위해 사용하는 컬럼의 이름이 동일한 경우
      ON 대신 USING 키워드를 사용할 수 있다
    - USING을 사용하면 조인에 사용했던 컬럼의 이름 중복 문제가 해결된다
*/
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.departments_id = d.department_id
WHERE
    salary >= 8000;

-- 테이블 연결에 사용되는 두 컬럼의 이름이 같은 경우 문법이 훨씬 간편해진다
SELECT
    *
FROM
         employees
    INNER JOIN departments USING ( department_id )
WHERE  
    salary <= 5000;
    
-- 연습1: 모든 사원들의 사원번호/이름/직책이름(job_title)을 조회해보세요
SELECT
    employee_id,
    first_name,
    job_title
FROM
         employees
    INNER JOIN jobs USING ( job_id )
ORDER BY employee_id;

-- 연습2: job_title이 Programmer인 사원들의 사원번호/이름/부서번호/부서명을 조회해보세요
SELECT
    employee_id,
    first_name,
    department_id
FROM
         employees
    INNER JOIN jobs USING ( job_id )
    INNER JOIN departments USING ( department_id )
WHERE
    job_title = 'Programmer';

-- 연습3: 커미션을 받는 사원들의 직책이름(job_title)에 무엇이 있는지 조회해보세요
SELECT DISTINCT
    job_title
FROM
        employees
    INNER JOIN jobs USING ( job_id )
WHERE
    commission_pct IS NOT NULL;

-- 연습4: Seattle에서 근무하는 사원들의 이름/월급/부서명/우편번호를 조회해보세요
--       Hint. Seattle은 locations 테이블에 있다
SELECT
    first_name,
    salary,
    department_name,
    postal_code
FROM
         employees
    INNER JOIN departments USING ( department_id )
    INNER JOIN locations USING ( location_id )
WHERE
    city = 'Seattle'
ORDER BY
    first_name;
    
/*
    # OUTER JOIN (조건을 충족하지 않는 행도 등장하는 것)
    
    1. LEFT OUTER JOIN  : 오른쪽 테이블에 (+)를 추가하는 효과
    2. RIGHT OUTER JOIN : 왼쪽 테이블에 (+)를 추가하는 효과
    3. FULL OUTER JOIN  : 양쪽 모두에 (+)를 추가하는 효과
*/

-- LEFT OUTER JOIN : 왼쪽 테이블에서 등장하지 못했던 행이 등장하는 OUTER JOIN
--                   오른쪽에 (+)를 붙인 효과
SELECT * FROM employees LEFT OUTER JOIN departments USING (department_id);

-- LEFT OUTER JOIN : 오른쪽 테이블에서 등장하지 못했던 행이 등장하는 OUTER JOIN
--                   왼쪽에 (+)를 붙인 효과
SELECT * FROM employees RIGHT OUTER JOIN departments USING (department_id);

-- ANSI JOIN을 쓰지 않으면 양쪽에 (+)를 붙이지 못한다
SELECT
    *
FROM
    employees   e,
    departments d
WHERE
    e.department_id (+) = d.department_id (+);

-- FULL OUTER JOIN : 양 테이블 모두에서 등장하지 못했던 행이 모두 드러난다
SELECT * FROM employees FULL OUTER JOIN departments USING (department_id);

-- 연습1: 사원이름/담당매니저이름을 모두 출력하되 담당하는 매니저가 없는 사원도 출력해보세요
SELECT
    emp.first_name || ' ' || emp.last_name AS "사원 이름",
    mgr.first_name || ' ' || mgr.last_name AS "담당매니저 이름"
FROM
         employees emp
    LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id;
    
-- 연습2: 모든 지역의 "소속도시이름/주소/우편번호/소속부서존재여부"를 조회해보세요
SELECT DISTINCT
    city,
    street_address,
    postal_code,
    location_id,
    CASE
        -- 등장하지 못했던 행 (소속 부서가 없는 경우)
        WHEN department_id IS NULL THEN 'X'
        -- 나머지는 여러번 등장하더라도 같은 결과인 O이기 때문에 DISTINCT로 압축 가능
        ELSE 'O'
    END AS "hasDept"
FROM
    locations
    LEFT OUTER JOIN departments USING ( location_id )
ORDER BY
    location_id;
    
