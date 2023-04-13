CREATE TABLE departments (
    dept_no VARCHAR(30) NOT NULL,
    dept_name VARCHAR(30),
	PRIMARY KEY (dept_no)
);

SELECT *
FROM departments



CREATE TABLE dept_emp(
    emp_no INT NOT NULL,
    dept_no VARCHAR(30),
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

ALTER TABLE dept_emp
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

SELECT *
FROM dept_emp



CREATE TABLE dept_manager (
    dept_no VARCHAR (30),
    emp_no INT NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no) 
);

ALTER TABLE dept_manager
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

SELECT *
FROM dept_manager



CREATE TABLE employees (
    emp_no INT NOT NULL,
	emp_title_id VARCHAR (30),
    birth_date VARCHAR(30),
	first_name VARCHAR (30),
	last_name VARCHAR (30),
	sex VARCHAR (10),
	hire_date VARCHAR (30),
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


-- had to update hire date to DATE type here
UPDATE employees
SET new_col = TO_DATE(hire_date, 'MM/DD/YYYY')

ALTER TABLE employees
DROP hire_date;

ALTER TABLE employees
RENAME new_col TO hire_date

SELECT *
FROM employees



CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT,
	PRIMARY KEY (emp_no)
);

ALTER TABLE salaries
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

SELECT *
FROM salaries


CREATE TABLE titles (
    title_id VARCHAR(30) NOT NULL,
    title VARCHAR(30),
	PRIMARY KEY (title_id)
);

SELECT *
FROM titles

--List the employee number, last name, first name, sex, and salary of each employee
CREATE VIEW emp_salary AS
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986
CREATE VIEW hired_86 AS
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE date_part('year', hire_date) = 1986

--List the manager of each department along with their department number, department name, employee number, last name, and first name
CREATE VIEW manager_dept AS
SELECT dept_manager.dept_no, dept_manager.emp_no, departments.dept_name, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON
dept_manager.dept_no = departments.dept_no 
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name 
CREATE VIEW emp_dept AS
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
CREATE VIEW hercules_b AS
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE employees.first_name = 'Hercules' AND
employees.last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name
CREATE VIEW sales_dept_ee AS
SELECT departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
CREATE VIEW sales_dev_depts AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR
departments.dept_name = 'Development'

--List the frequency counts, in descending order, of all the employee last names (counts of employees who share each last name)
CREATE VIEW last_name_freq AS
SELECT employees.last_name, count(*)
FROM employees
GROUP BY employees.last_name
ORDER BY count desc

