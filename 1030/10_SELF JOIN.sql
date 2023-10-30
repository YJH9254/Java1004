-- 10_SELF JOIN.sql

/* 
    # SELF JOIN
    
    - 하나의 테이블이 자기 자신의 컬럼과 JOIN하여 원하는 데이터를 얻어내는 경우
    - 자기 자신 테이블의 기본키를 외래키로 삼아 사용하는 경우
      ex: employees의 manager_id는 employee_id를 참조하는 외래키이다
    - 셀프 조인의 경우 모든 컬럼의 이름이 동일하므로 테이블명을 반드시 명시해야 한다
      컬럼명 앞에 테이블명을 반드시 명시해야 한다
*/
SELECT * FROM employees;

SELECT
    emp.first_name || ' ' || emp.last_name AS "사원 이름",
    mgr.first_name || ' ' || mgr.last_name AS "매니저 이름"
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id;
    
-- 연습1: 매니저 이름에 e가 포함되는 사원들의 모든 정보를 조회해보세요
SELECT emp.* FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id AND lower(mgr.first_name) LIKE '%e%'
ORDER BY emp.employee_id;
    
-- 연습2: 담당하는 사원이 8명 이상인 매니저들의 정보를 조회해보세요
SELECT
    *
FROM
    employees
WHERE
    employee_id IN (
        SELECT
            manager_id
        FROM
            employees
        GROUP BY
            manager_id
        HAVING
            COUNT(*) >= 8
    );
