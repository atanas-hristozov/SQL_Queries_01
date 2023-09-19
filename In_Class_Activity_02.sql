SELECT FLOOR(AVG(salary)) AS average_salary FROM employees WHERE YEAR(hire_date) <= 1999;
SELECT name FROM towns WHERE LOWER(RIGHT(name, 1)) IN ('a', 'o', 'u', 'e', 'i');
SELECT name FROM towns WHERE LOWER(LEFT(name, 1)) IN ('a', 'o', 'u', 'e', 'i');
SELECT name, LENGTH(name) AS town_name_lenght FROM towns ORDER BY LENGTH(name) DESC LIMIT 1;
SELECT name, LENGTH(name) AS town_name_length FROM towns ORDER BY LENGTH(name) ASC LIMIT 1;
SELECT * FROM employees WHERE employees.employee_id % 2 = 0;
SELECT first_name, salary FROM employees WHERE salary = (SELECT MIN(salary) FROM employees);
SELECT first_name, salary FROM employees WHERE salary <= 1.1 * (SELECT MIN(salary) FROM employees);
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.salary, d.department_id
FROM employees e INNER JOIN (
    SELECT department_id, MIN(salary) AS min_salary
    FROM employees
    GROUP BY department_id
) min_salaries ON e.department_id = min_salaries.department_id AND e.salary = min_salaries.min_salary
         INNER JOIN departments d ON e.department_id = d.department_id;
SELECT AVG(salary) AS average_salary FROM employees WHERE department_id = 1;
SELECT AVG(salary) AS average_salary
FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_id = 3);
SELECT COUNT(*) AS num_employees FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_id = 3);
SELECT COUNT(*) AS num_employees_with_manager FROM employees WHERE manager_id IS NOT NULL;
SELECT COUNT(*) AS num_employees_without_manager FROM employees WHERE manager_id IS NULL;
SELECT d.department_id, AVG(e.salary) AS average_salary
FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.name;
SELECT project_id, start_date, end_date FROM projects WHERE DATEDIFF(end_date, start_date) < 365;
SELECT e.first_name, e.last_name FROM employees e WHERE e.employee_id IN (
    SELECT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id
    HAVING COUNT(*) = 5);
SELECT
    e1.employee_id,
    e1.first_name AS employee_first_name,
    e1.last_name AS employee_last_name,
    IFNULL(CONCAT(e2.first_name, ' ', e2.last_name), '(no manager)') AS manager_name
FROM employees e1 LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;
SELECT first_name, last_name FROM employees WHERE LENGTH(last_name) = 5;
SELECT DATE_FORMAT(NOW(3), '%d.%m.%Y %H:%i:%s:%f') AS formatted_datetime;
SELECT d.name, e.job_title, AVG(e.salary) AS average_salary
FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.name, e.job_title;
SELECT
    e1.employee_id AS manager_id,
    CONCAT(e1.first_name, ' ', e1.last_name) AS manager_name,
    COUNT(e2.employee_id) AS num_employees,
    AVG(e2.salary) AS average_salary
FROM employees e1
         LEFT JOIN employees e2 ON e1.employee_id = e2.manager_id
GROUP BY e1.employee_id, manager_name
ORDER BY num_employees DESC
LIMIT 1;
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, COUNT(p.project_id) AS num_projects
FROM employees e
         LEFT JOIN employees_projects ep ON e.employee_id = ep.employee_id
         LEFT JOIN projects p ON ep.project_id = p.project_id
GROUP BY e.employee_id, employee_name ORDER BY num_projects DESC LIMIT 1;