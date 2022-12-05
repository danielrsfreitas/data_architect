-- Question 1 CRUD
-- Return a list of employees with Job Titles and Department Names
select e.emp_nm, jt.job_title, d.department 
from employee as e
join job as j
on e.emp_id = j.emp_id
join department as d
on j.department_id = d.department_id
join job_title as jt
on jt.job_title_id = j.job_title_id;

-- Question 2 CRUD
-- Insert Web Programmer as a new job title
insert into job_title(job_title)
values('Web Programmer');

-- Question 3 CRUD
-- Correct the job title from web programmer to web developer
update job_title
set job_title = 'Web Developer'
where job_title = 'Web Programmer';

-- Question 4 CRUD
-- Delete the job title Web Developer from the database
delete from job_title
where job_title = 'Web Developer';

-- Question 5 CRUD
-- How many employees are in each department?
select count(e.emp_id) as num_employees, d.department
from employee as e
join job as j
on e.emp_id = j.emp_id
join department as d
on j.department_id = d.department_id
where j.end_dt > now()
group by
d.department;

-- Question 6 CRUD
-- Write a query that returns current and past jobs 
-- (include employee name, job title, department, 
-- manager name, start and end date for position) for employee Toni Lembeck.
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
where e.emp_nm = 'Toni Lembeck';