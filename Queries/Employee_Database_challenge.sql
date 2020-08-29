--Create retirement titles table
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Create unique titles table
SELECT DISTINCT ON (r.emp_no) r.emp_no, r.first_name, r.last_name, r.title
INTO unique_titles
FROM retirement_titles as r
ORDER BY r.emp_no, r.to_date DESC;

-- Number of retiring employees by title
SELECT 
	COUNT (title) as count,
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--Create mentorship eligibility table
SELECT DISTINCT ON (e.emp_no)  e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Create unique mentorship titles table
SELECT DISTINCT ON (m.emp_no) m.emp_no, m.first_name, m.last_name, m.title
INTO unique_mentorship_titles
FROM mentorship_eligibility as m
ORDER BY m.emp_no;

-- Number of eligible mentorship employees by title
SELECT 
	COUNT (title) as count,
	title
INTO mentorship_titles
FROM unique_mentorship_titles
GROUP BY title
ORDER BY count DESC;

--Create expanded mentorship eligibility table
SELECT DISTINCT ON (e.emp_no)  e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO expanded_mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1970-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Create expanded unique mentorship titles table
SELECT DISTINCT ON (m.emp_no) m.emp_no, m.first_name, m.last_name, m.title
INTO expanded_unique_mentorship_titles
FROM expanded_mentorship_eligibility as m
ORDER BY m.emp_no;

-- Number of eligible mentorship employees by title
SELECT 
	COUNT (title) as count,
	title
INTO expanded_mentorship_titles
FROM expanded_unique_mentorship_titles
GROUP BY title
ORDER BY count DESC;

--Create current employees table
SELECT DISTINCT ON (e.emp_no)  e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO current_employees
FROM employees as e
LEFT JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '9999-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Create expanded current employee titles table
SELECT DISTINCT ON (m.emp_no) m.emp_no, m.first_name, m.last_name, m.title
INTO current_employees_titles
FROM current_employees as m
ORDER BY m.emp_no;

-- Number of eligible current employees by title
SELECT 
	COUNT (title) as count,
	title
INTO current_employee_titles_count
FROM current_employee_titles
GROUP BY title
ORDER BY count DESC;