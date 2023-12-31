-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/W6AAWV
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" char(4)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_Emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" char(4)   NOT NULL,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Dept_Manager" (
    "dept_no" char(4)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" char(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" char(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" char(5)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
	"Employees"."emp_no",
	"Employees"."last_name",
	"Employees"."first_name",
	"Employees"."sex",
	"Salaries"."salary"
FROM 
	"Employees"
INNER JOIN 
	"Salaries" ON
	"Employees"."emp_no" = "Salaries"."emp_no";

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
	"Employees"."first_name",
	"Employees"."last_name",
	"Employees"."hire_date"
FROM 
	"Employees"
WHERE EXTRACT(YEAR FROM "Employees"."hire_date") = 1986;
	
--List the manager of each department along with their department number, department name, employee number, last name, and first name.	

SELECT 
	"Dept_Manager"."emp_no",
	"Dept_Manager"."dept_no",
	"Departments"."dept_name",
	"Employees"."first_name",
	"Employees"."last_name"
FROM 
	"Employees"
INNER JOIN 
	"Dept_Manager" ON
	"Employees"."emp_no" = "Dept_Manager"."emp_no"
INNER JOIN
	"Departments" ON
	"Dept_Manager"."dept_no" = "Departments"."dept_no"

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT 
	"Dept_Emp"."emp_no",
	"Dept_Emp"."dept_no",
	"Departments"."dept_name",
	"Employees"."first_name",
	"Employees"."last_name"
FROM 
	"Employees"
INNER JOIN 
	"Dept_Emp" ON
	"Employees"."emp_no" = "Dept_Emp"."emp_no"
INNER JOIN
	"Departments" ON
	"Dept_Emp"."dept_no" = "Departments"."dept_no"

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT 
	"Employees"."first_name",
	"Employees"."last_name",
	"Employees"."sex"
FROM 
	"Employees"
WHERE "Employees"."first_name" = 'Hercules' AND "Employees"."last_name" LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
	"Dept_Emp"."emp_no",
	"Dept_Emp"."dept_no",
	"Departments"."dept_name",
	"Employees"."first_name",
	"Employees"."last_name"
FROM 
	"Employees"
INNER JOIN 
	"Dept_Emp" ON
	"Employees"."emp_no" = "Dept_Emp"."emp_no"
INNER JOIN
	"Departments" ON
	"Dept_Emp"."dept_no" = "Departments"."dept_no"
WHERE "Departments"."dept_name" = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
	"Dept_Emp"."emp_no",
	"Dept_Emp"."dept_no",
	"Departments"."dept_name",
	"Employees"."first_name",
	"Employees"."last_name"
FROM 
	"Employees"
INNER JOIN 
	"Dept_Emp" ON
	"Employees"."emp_no" = "Dept_Emp"."emp_no"
INNER JOIN
	"Departments" ON
	"Dept_Emp"."dept_no" = "Departments"."dept_no"
WHERE "Departments"."dept_name" = 'Sales' OR "Departments"."dept_name" = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT "Employees"."last_name", count(last_name)
FROM "Employees"
GROUP BY 1
ORDER BY 2 DESC;

