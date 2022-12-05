-- Standout suggestion 1
-- Create a view that returns all employee attributes; results should 
-- resemble the initial Excel file.
create view hr_view as select
e.emp_id,
e.emp_nm,
e.email,
e.hire_dt,
jt.job_title,
s.salary,
d.department,
t.manager,
j.start_dt,
j.end_dt,
g.location,
g.address,
g.city,
g.state,
el.education_level
from employee as e
join (
    select 
    a.emp_nm as manager,
    b.manager_id
    from employee as a
    join employee as b
    on a.emp_id = b.manager_id
    group by
    b.manager_id,
    manager
) t
on t.manager_id = e.manager_id
join education_level as el
on e.education_level_id = el.education_level_id
join geography as g
on e.geography_id = g.geography_id
join job as j
on e.emp_id = j.emp_id
join department as d
on j.department_id = d.department_id
join job_title as jt
on j.job_title_id = jt.job_title_id
join salary as s
on j.salary_id = s.salary_id;

-- Standout suggestion 2
-- Create a stored procedure with parameters that return current and past jobs 
-- (include employee name, job title, department, manager name, start and end date for the position)
-- when given an employee name.

create or replace procedure select_historical_job(name varchar)
language SQL
as $$
select e.emp_nm, jt.job_title, d.department, t.manager, j.start_dt, j.end_dt
from employee as e
join (
    select 
    a.emp_nm as manager,
    b.manager_id
    from employee as a
    join employee as b
    on a.emp_id = b.manager_id
    group by
    b.manager_id,
    manager
) t
on t.manager_id = e.manager_id
join job as j
on e.emp_id = j.emp_id
join job_title as jt
on j.job_title_id = jt.job_title_id
join department as d
on j.department_id = d.department_id
where e.emp_nm = name;
$$;

-- Standout suggestion 3
-- Implement user security on the restricted salary attribute.

grant select on HR_DB
to NoMgr;

revoke all privileges on SALARY from NoMgr;