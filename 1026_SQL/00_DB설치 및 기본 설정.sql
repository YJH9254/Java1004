-- 00_DB설치 및 기본 설정.sql

/*
    # Oracle XE 11g 다운로드 및 설치
    1. 구글링
    2. 다운로드
    3. 설치 (설치 시 사용하는 포트번호 확인할 것: 1521, 2030, 8080)
    
    # 설치 후 확인해보기
    1. cmd에서 sqlplus로 실행 여부 확인 (설치 완료)
    2. 관리자 계정으로 로그인 해보기 (sys as sysdba / 1234)
    3. sql developer를 다운 받아서 관리자 계정으로 로그인해보기
       (sys, 롤을 sysdba로 변경한 후 접속)
       
    # 연습용 계정 설정하기
    
    1. 관리자 계정으로 로그인
    2. ALTER USER hr ACCOUNT UNLOCK; (잠금해제 하지 않으면 접속 불가능)
    3. ALTER USER hr IDENTIFIED BY 1234; (비밀번호 변경)
*/

-- CTRL + ENTER : 명령어 하나 실행하기
-- F5 : 이 스크립트의 모든 명령어 실행하기
-- HR : 연습용 계정
-- SYS, SYSTEM : 관리자 계정

-- 데이터베이스에서 사용하는 주석

-- 현재 데이터베이스의 테이블 목록 보기
SELECT * FROM tabs;

-- 현재 데이터베이스의 계정 목록 보기
SELECT * FROM all_users; 

-- 연습용 계정 HR 잠금 해제하기
ALTER USER hr ACCOUNT UNLOCK;
-- 연습용 계정 HR 비밀번호 변경하기
ALTER USER hr IDENTIFIED BY 1234;

