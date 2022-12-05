CREATE TABLE GEOGRAPHY(
    GEOGRAPHY_ID SERIAL PRIMARY KEY,
    LOCATION VARCHAR(50),
    ADDRESS VARCHAR(100),
    CITY VARCHAR(50),
    STATE VARCHAR(2)
);

CREATE TABLE SALARY(
    SALARY_ID SERIAL PRIMARY KEY,
    SALARY int
);

CREATE TABLE DEPARTMENT(
    DEPARTMENT_ID SERIAL PRIMARY KEY,
    DEPARTMENT VARCHAR(50)
);

CREATE TABLE EDUCATION_LEVEL(
    EDUCATION_LEVEL_ID SERIAL PRIMARY KEY,
    EDUCATION_LEVEL VARCHAR(50)
);

CREATE TABLE JOB_TITLE(
    JOB_TITLE_ID SERIAL PRIMARY KEY,
    JOB_TITLE VARCHAR(100)
);

CREATE TABLE EMPLOYEE(
    EMP_ID VARCHAR(10) PRIMARY KEY,
    MANAGER_ID VARCHAR(10) REFERENCES EMPLOYEE(EMP_ID),
    EMP_NM VARCHAR(100),
    EMAIL VARCHAR(50),
    HIRE_DT DATE,
    GEOGRAPHY_ID INT REFERENCES GEOGRAPHY(GEOGRAPHY_ID),
    EDUCATION_LEVEL_ID INT REFERENCES EDUCATION_LEVEL(EDUCATION_LEVEL_ID)
);

CREATE TABLE JOB(
    JOB_ID SERIAL PRIMARY KEY,
    EMP_ID VARCHAR(10) REFERENCES EMPLOYEE(EMP_ID),
    DEPARTMENT_ID INT REFERENCES DEPARTMENT(DEPARTMENT_ID),
    JOB_TITLE_ID INT,
    START_DT DATE,
    END_DT DATE,
    SALARY_ID INT REFERENCES SALARY(SALARY_ID)
);