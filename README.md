# Introduction
The Datase i used is for the Job market! I specifically focused on Data Analyst roles, exploring problem statements such as Top-paying jobs, Top in-demand skills, and best optimal skills for Data analysts i.e. where high demand meets high salary. 

Here ar the SQL queires i used to generate my various insights:
[project_sql_postgres](/project_sql/)

# Background
I was interested in knowing how the job market for Data Analyst looks like in a more consise way. I decided to use this dataset that showcases insights such as job titles, salaries, locations, companies offering them,skills associated with each job posting and more. I got the dataset from a Youtube channel of a data analyst called Lukebarousse.

### Problem statements I decided to use to answer my SQL queries
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are in most demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
The tools I used to generate my insights for the project include the following:
- **SQL**
- **PostgreSQL :** My ideal database management that is linked to my code editor.
- **Visual Studio Code**: My ideal code editor for SQL queries
- **Git and GitHub:** Needed a version control to showcase the steps and changes  made as I progressed with my analysis. Also ideal for sharing and collaboration purposes.

# The Analysis
I approached every problem statement individually seeking to get a consise answer for every question
### 1.What are the top-paying data analyst jobs?
I created a query that woulc showcase the companies that offered the highest paying jobs for Data analysts together with the salary avg for the job posting.Furthermore, I filtered the query to include remote jobs and salary values that were not nulll. I joined two separate tables that had the job posting, salaries and the companies on opposite sides.
To avoid having  alarge query i limited the results by the top 20.

```SQL
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    20;
```
#### **Insights I gained from the problem statement:**
- Salaries range from $165,000 dollars a year to $650,000. The companies offering the job postings are very different. The job roles are also very diverse even when categorised solely for Data Analysts.

### 2.What skills are required for these top-paying jobs?
Next, I generate a query that would showcase the top skills required for the top paying jobs for Data Analysts. I took the sql query from my first problem statement and pasted it in the second question and wrapped it in a CTE. I then joined the new CTE with the skills csv file to generate the skills attached to each top paying job on the market together with the company name and job title.

```SQL
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim
        ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
JOIN
    skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

#### **Insights I gained from the problem statement:**
- Some of the skills required for these high paying Data Analyst jobs include tools such as SQL,PYTHON,PANDAS,R,EXCEL, POWER BI, AND TABLEAU. They also include database management skills in AWS,AZURE AND ORACLE including many more in fields such as specialised data warehouse management i.e. snowflake.
- Some of these skills are also tied to a specific job role with a specific company for example AT&T rquire 8 different skills for the Associate Director- Data Insights position, same with Pinterest Job Advertising, UCLA Health Careers and many more.

### 3.What skills are in most demand for data analysts?
This was one of the main problem statements that i was curious to find out. I wanted to identify which skills are highly demanded by companies for Data Analyst roles. I approached it in two ways: option one using a CTE and option two using purely JOIN statements.
For both I specified the query to filter out the results to include remote positions only.

```SQL
-- 1. With a CTE
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
        
    FROM
        skills_job_dim AS skills_to_job
    JOIN
        job_postings_fact as job_postings
        ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE
        AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT
    skill.skill_id,
    skill.skills AS skill_name,
    remote_job_skills.skill_count
FROM   
    remote_job_skills
JOIN
    skills_dim AS skill
    ON remote_job_skills.skill_id = skill.skill_id
ORDER BY
    skill_count DESC
LIMIT
    5;


-- 2. With JOINS

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
JOIN
    skills_job_dim
    ON  job_postings_fact.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT
    5

-- Both produce the same result
```

#### **Insights I gained from the problem statement:**
- The most in-demand skills for Data Analaysts include in order: SQL, Excel,Python,Tableau and Power Bi

### 4.Which skills are associated with higher salaries?
I also wanted to identify which skills are associated with the highest salaries. I joined three tables together with an INNER JOIN to retrieve the average salary for each skill and whcih ones were at the top while also limiting the queries to salary values that weren't NULL. To simplify the query, I limited the result to show the top 25.

```SQL
SELECT
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary_per_skill
FROM
    job_postings_fact
JOIN
    skills_job_dim
    ON  job_postings_fact.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary_per_skill DESC
LIMIT
    25
```
#### **Insights I gained from the problem statement:**
- 
### 5.What are the most optimal skills to learn?
Finally, I wanted to showcase which skills are in-demanded and high-paying i.e. optimal skills. I wanted columns that showcased the skill id, skill count, demand count for each skill queried and average salary for each skill. I generated two CTEs from the previous problem statement 3 and 4 that I named skills_demand avg_salary.Made sure to confimr that the query filtered based on Data Analyst roles, remote positions and salary values weren't NULL.
I also limited the demand count to be greater than 10 for more accurate reults. I ordered the final result by the highest average slary for the skill and demand count while also limting the query to include only the top 25.

```SQL
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    JOIN
        skills_job_dim
        ON  job_postings_fact.job_id = skills_job_dim.job_id
    JOIN
        skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.job_work_from_home = TRUE
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        demand_count DESC
), avg_salary AS(
    SELECT
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg),2) AS avg_salary_per_skill
    FROM
        job_postings_fact
    JOIN
        skills_job_dim
        ON  job_postings_fact.job_id = skills_job_dim.job_id
    JOIN
        skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY
       skills_dim. skill_id
    ORDER BY
        avg_salary_per_skill DESC
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary_per_skill
FROM
  skills_demand
JOIN
    avg_salary
    ON skills_demand.skill_id = avg_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary_per_skill DESC,
    demand_count DESC
LIMIT
    25;
```

# What I learned

# Conclusions
