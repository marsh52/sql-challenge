DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS departments;


CREATE TABLE departments (
	dept_no VARCHAR(5) PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR(5) REFERENCES titles (title_id) NOT NULL,
	birth_date DATE  NOT NULL,
	first_name VARCHAR(30),
	last_name VARCHAR(30) NOT NULL,
	sex CHAR,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INTEGER REFERENCES employees (emp_no),
	dept_no VARCHAR(5) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(5) REFERENCES departments (dept_no),
	emp_no INTEGER REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
	emp_no INTEGER REFERENCES employees (emp_no) NOT NULL UNIQUE,
	salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no, salary)
);

