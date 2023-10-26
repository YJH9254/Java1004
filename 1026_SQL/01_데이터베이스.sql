-- 01_데이터베이스.sql

/*
    # 데이터베이스 (Database, DB)
    
    - 데이터 창고
    - 파일에 데이터를 저장하다보니 많은 문제점과 한계들을 만나게 되었고
      그것을 극복하고자 만들어진 데이터 저장 전문 프로그램
    - 데이터를 효율적으로 저장하고 검색할 수 있다
    
    # 파일 시스템의 문제점
    
    - 데이터 수정 시 데이터간의 불일치를 유발할 수 있다
    - 다수의 사용자가 하나의 파일에 동시에 접속할 수 없다
    - 중복 데이터를 필요 이상으로 많이 저장하게 된다
    - 보안이 취약하다 (보안에 대한 별도 구현이 필요하다)
    - 파일 복구 기능을 따로 구현해야 한다
    
    # DBMS (Database Management System)
    
    - 데이터베이스를 관리하는 프로그램
    - 데이터베이스는 데이터가 보관되는 장소이고
      그 데이터베이스를 총괄하는 프로그램을 DBMS라고 한다
    
    # RDBMS (Relational DBMS)
    
    - 관계형 데이터베이스
    - 데이터들간의 관계를 이용해 데이터 중복을 최소화하는 방식의 DBMS
    - 질의문 형식의 명령어(SQL, Query)를 통해 데이터베이스를 관리한다
    - 기본적인 질의문은 국제 표준을 따라야하기 때문에 RDBMS들의 명령어는 거의 유사하다
    - 데이터를 표 형태로 저장한다
    
    # 테이블
    
    - 관계형 데이터베이스에서는 데이터를 표 형태로 저장한다
    - 필드(열, 컬럼, 속성) : 한 열에 저장되는 데이터들을 대표하는 이름
    - 레코드(행, 로우, 튜플) : 한 행에 저장되는 하나의 개체를 나타내는 데이터 묶음
    
    # SQL명령어(SELECT, FROM, WHERE, OTHER BY, LIMIT, SELECT DISTINCT, JOIN)
    
    - 관계형 데이터베이스를 관리하기 위한 질문같이 생긴 명령어
    - 쿼리문, 질의문 등으로 불린다
*/

-- tab, tabs, user_tables : 현재 계정이 가지고 있는 테이블들을 볼 수 있는 테이블
SELECT * FROM tab;
SELECT * FROM tabs;
SELECT * FROM user_tables;

-- SELECT : 해당 테이블의 내용을 조회할 수 있는 질의문
SELECT * FROM employees;
SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
