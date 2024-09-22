/* 
SQL Challenge Queries
  Each question is included below, I decided to include a sub-select and a join solution for applicable questions,
  to get practice with both.
  For strings, I decided to set the varchar length to be a bit higher than the values in the tables.
*/

-- 1. List the employee number, last name, first name, sex, and salary of each employee.

   SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
     FROM employees AS e
LEFT JOIN salaries AS s ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
  FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, 
-- 	  last name, and first name.

   SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
     FROM dept_manager as dm
LEFT JOIN departments as d
       ON dm.dept_no = d.dept_no
LEFT JOIN employees as e
       ON dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, 
--	  first name, and department name.

   SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
     FROM employees AS e
LEFT JOIN dept_emp AS de
       ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
       ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name 
-- 	  begins with the letter B.

SELECT first_name, last_name, sex
  FROM employees
 WHERE first_name = 'Hercules'
   AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

--    Sub-select method

SELECT emp_no, last_name, first_name
  FROM employees
 WHERE emp_no IN 
  (SELECT emp_no 
     FROM dept_emp
    WHERE dept_no = 
    (SELECT dept_no 
       FROM departments
      WHERE dept_name = 'Sales'));

--    Join method

   SELECT e.emp_no, e.last_name, e.first_name
     FROM employees AS e
LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
LEFT JOIN departments AS d ON d.dept_no = de.dept_no
    WHERE d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name,
--    first name, and department name.

--	  Sub-select method

    SELECT e.emp_no, e.last_name, e.first_name, t.dept_name
      FROM employees AS e
INNER JOIN
    (SELECT d.dept_no, d.dept_name, de.emp_no 
       FROM departments AS d
  LEFT JOIN dept_emp AS de
         ON d.dept_no = de.dept_no
      WHERE dept_name = 'Development' OR dept_name = 'Sales') AS t
        ON t.emp_no = e.emp_no
  ORDER BY e.emp_no;
  
--	  Join method

   SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
     FROM employees AS e
LEFT JOIN dept_emp AS de
       ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
       ON de.dept_no = d.dept_no
    WHERE d.dept_no = 'd005' OR de.dept_no = 'd007'
 ORDER BY e.emp_no;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

  SELECT last_name, COUNT(last_name) as count 
    FROM employees 
GROUP BY last_name
ORDER BY count DESC;
