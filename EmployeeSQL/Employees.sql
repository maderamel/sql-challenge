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