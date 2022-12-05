-- ETL to insert the data in the respective tables
INSERT INTO SALARY (SALARY)
SELECT DISTINCT(salary) FROM proj_stg;

INSERT INTO EDUCATION_LEVEL (EDUCATION_LEVEL)
SELECT DISTINCT(education_lvl) FROM proj_stg;

INSERT INTO JOB_TITLE (JOB_TITLE)
SELECT DISTINCT(job_title) FROM proj_stg;

INSERT INTO DEPARTMENT (DEPARTMENT)
SELECT DISTINCT(department_nm) FROM proj_stg;

INSERT INTO GEOGRAPHY (LOCATION, ADDRESS, CITY, STATE)
SELECT location, address, city, state FROM proj_stg
GROUP BY location, address, city, state;

INSERT INTO EMPLOYEE (
    EMP_ID,
    EMP_NM,
    MANAGER_ID,
    EMAIL,
    HIRE_DT,
    GEOGRAPHY_ID,
    EDUCATION_LEVEL_ID
)
SELECT 
    ps.Emp_ID,
    ps.Emp_NM,
    t.manager_id,
    ps.Email,
    ps.hire_dt,
    g.GEOGRAPHY_ID,
    el.EDUCATION_LEVEL_ID
FROM proj_stg AS ps
JOIN GEOGRAPHY AS g
ON ps.location = g.LOCATION AND ps.address = g.ADDRESS AND ps.city = g.CITY AND ps.state = g.STATE
JOIN EDUCATION_LEVEL AS el
ON ps.education_lvl = el.EDUCATION_LEVEL
LEFT JOIN(
    SELECT
    a.emp_nm AS manager,
    a.emp_id AS manager_id
    FROM proj_stg AS a
    JOIN proj_stg AS b
    ON a.emp_nm = b.manager
    GROUP BY
    a.emp_id,
    a.emp_nm,
    b.manager) t
ON t.manager = ps.manager 
WHERE ps.end_dt > NOW()
GROUP BY
    EMP_ID,
    EMP_NM,
    MANAGER_ID,
    EMAIL,
    HIRE_DT,
    GEOGRAPHY_ID,
    EDUCATION_LEVEL_ID
;


INSERT INTO JOB (
    JOB_TITLE_ID,
    EMP_ID,
    START_DT, 
    END_DT,
    DEPARTMENT_ID,
    SALARY_ID
)
SELECT 
    jt.job_title_id, 
    ps.emp_id,
    ps.start_dt,
    ps.end_dt,
    d.department_id, 
    s.salary_id
FROM proj_stg AS ps
JOIN DEPARTMENT AS d
ON ps.department_nm = d.department
JOIN SALARY AS s
ON ps.salary = s.salary
JOIN JOB_TITLE AS jt
ON ps.job_title = jt.job_title;