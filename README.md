# Introduction
The Datase I used is for the Job market! I specifically focused on Data Analyst roles, exploring problem statements such as Top-paying jobs, Top in-demand skills, and best optimal skills for Data analysts i.e. where high demand meets high salary. 

Here are the SQL queires I used to generate my various insights:
[project_sql_postgres](/project_sql/)

# Background
I was interested in knowing how the job market for Data Analyst looks like in a more consise way. I decided to use this dataset that showcases insights such as job titles, salaries, locations, companies offering them,skills associated with each job posting and more. I got the dataset from a YouTube channel of a data analyst called Lukebarousse.

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
- **Git and GitHub:** Needed a version control to showcase the steps and changes  made as I progressed with my analysis. It's also ideal for sharing and collaboration purposes.

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


![Top paying jobs](<assets/top paying jobs.png>)
*Bar graph showcasing the top 20 salaries for Data analysts and their specific roles*

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

| job_id | job_title                            | job_location | job_schedule_type | salary_year_avg | company_name                            | skills      |
|--------|--------------------------------------|--------------|-------------------|-----------------|-----------------------------------------|-------------|
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | sql         |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | python      |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | r           |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | azure       |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | databricks  |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | aws         |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | pandas      |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | pyspark     |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | jupyter     |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | excel       |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | tableau     |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | power bi    |
| 552322 | Associate Director- Data Insights    | Anywhere     | Full-time         | 255829.5        | AT&T                                   | powerpoint  |
| 99305  | Data Analyst, Marketing              | Anywhere     | Full-time         | 232423.0        | Pinterest Job Advertisements            | sql         |
| 99305  | Data Analyst, Marketing              | Anywhere     | Full-time         | 232423.0        | Pinterest Job Advertisements            | python      |
| 99305  | Data Analyst, Marketing              | Anywhere     | Full-time         | 232423.0        | Pinterest Job Advertisements            | r           |
| 99305  | Data Analyst, Marketing              | Anywhere     | Full-time         | 232423.0        | Pinterest Job Advertisements            | hadoop      |
| 99305  | Data Analyst, Marketing              | Anywhere     | Full-time         | 232423.0        | Pinterest Job Advertisements            | tableau     |
| 1021647 | Data Analyst (Hybrid/Remote)         | Anywhere     | Full-time         | 217000.0        | Uclahealthcareers                       | sql         |
| 1021647 | Data Analyst (Hybrid/Remote)         | Anywhere     | Full-time         | 217000.0        | Uclahealthcareers                       | crystal     |
| 1021647 | Data Analyst (Hybrid/Remote)         | Anywhere     | Full-time         | 217000.0        | Uclahealthcareers                       | oracle      |
| 1021647 | Data Analyst (Hybrid/Remote)         | Anywhere     | Full-time         | 217000.0        | Uclahealthcareers                       | tableau     |
| 1021647 | Data Analyst (Hybrid/Remote)         | Anywhere     | Full-time         | 217000.0        | Uclahealthcareers                       | flow        |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | sql         |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | python      |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | go          |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | snowflake   |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | pandas      |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | numpy       |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | excel       |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | tableau     |
| 168310 | Principal Data Analyst (Remote)      | Anywhere     | Full-time         | 205000.0        | SmartAsset                             | gitlab      |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | sql         |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | python      |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | azure       |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | aws         |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | oracle      |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | snowflake   |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | tableau     |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | power bi    |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | sap         |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | jenkins     |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | bitbucket   |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | atlassian   |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | jira        |
| 731368 | Director, Data Analyst - HYBRID      | Anywhere     | Full-time         | 189309.0        | Inclusively                            | confluence  |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | sql         |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | python      |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | r           |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | git         |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | bitbucket   |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | atlassian   |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | jira        |
| 310660 | Principal Data Analyst, AV Performance Analysis | Anywhere     | Full-time         | 189000.0        | Motional                               | confluence  |
| 1749593 | Principal Data Analyst                 | Anywhere     | Full-time         | 186000.0        | SmartAsset                             | sql         |
| 1749593 | Principal Data Analyst                 | Anywhere     | Full-time         | 186000.0        | SmartAsset                             | python      |
| 1749593 | Principal Data Analyst                 | Anywhere     | Full-time         | 186000.0        | SmartAsset


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

![top demanded skills](<assets/top demanded skills.png>)
*Pie chart showcasing the top 5 most demanded skills for Data anlysts*

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
- All the top skills average more than $115,000 per year. The skills vary in different fields such as Big Data and Cloud infalstructure i.e. terraform, cassandra,kafka,couchbase and vmware, Machine Learning and A.I. i.e. keras, pytorch and tensorflow, and DevOps and Automation i.e. gitlab and puppet.
- The highest paying skill is svn, which is a version control system, at $400,000.

![top paying skills](<assets/top paying skills.png>)
*scatterplot chart showcasing the top paying skills to have as a data analyst*

### 5.What are the most optimal skills to learn?
Finally, I wanted to showcase which skills are in-demanded and high-paying i.e. optimal skills. I wanted columns that showcased the skill id, skill count, demand count for each skill queried and average salary for each skill. I generated two CTEs from the previous problem statement 3 and 4 that I named skills_demand and avg_salary. Made sure to confirm that the query filtered based on Data Analyst roles, remote positions and salary values weren't NULL.
I also limited the demand count to be greater than 10 for more accurate reults. I ordered the final result by the highest average salary for the skill and demand count while also limiting the query to include only the top 25.

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
#### **Insights I gained from the problem statement:**
- The top 5 skills that are higly paid include go, confluence,hadoop,snowflake,and azure.These skills have relatively high average salaries with moderately high demand counts, indicating that these skills are specialized and highly valued.
- What's also noteworthy is that the skills that take up a demand of more than 100 are tied to Data Analytics i.e. SQL, excel, python,tableau and r.

| skill_id | skills      | demand_count | avg_salary_per_skill |
|----------|-------------|--------------|----------------------|
| 8        | go          | 27           | 115319.89            |
| 234      | confluence  | 11           | 114209.91            |
| 97       | hadoop      | 22           | 113192.57            |
| 80       | snowflake   | 37           | 112947.97            |
| 74       | azure       | 34           | 111225.10            |
| 77       | bigquery    | 13           | 109653.85            |
| 76       | aws         | 32           | 108317.30            |
| 4        | java        | 17           | 106906.44            |
| 194      | ssis        | 12           | 106683.33            |
| 233      | jira        | 20           | 104917.90            |
| 79       | oracle      | 37           | 104533.70            |
| 185      | looker      | 49           | 103795.30            |
| 2        | nosql       | 13           | 101413.73            |
| 1        | python      | 236          | 101397.22            |
| 5        | r           | 148          | 100498.77            |
| 78       | redshift    | 16           | 99936.44             |
| 187      | qlik        | 13           | 99630.81             |
| 182      | tableau     | 230          | 99287.65             |
| 197      | ssrs        | 14           | 99171.43             |
| 92       | spark       | 13           | 99076.92             |
| 13       | c++         | 11           | 98958.23             |
| 7        | sas         | 63           | 98902.37             |
| 186      | sas         | 63           | 98902.37             |
| 61       | sql server  | 35           | 97785.73             |
| 9        | javascript  | 20           | 97587.00             |



# Conclusions
After dissecting the dataset through SQL and plotting some of my findings using Tableau, I was able to conclude the following:

1. **Skills associated with Data Analytics:** The top skills every Data analyst or aspiring Data analyst should focus more on as per the data are SQL, Excel, Python,Tableau and Power Bi.
2. **Top paying jobs:** Top paying Data analyst jobs can range anywhere between $160,000 to 350,000 per year in terms of salary with the highest salary at $650,000.
3. **Potential for increased salaries:** If a Data analyst wants to increase their chances of bumping up their salary, they should consider adding the following top 5 skills to their tookit as they are very lucrative- SVN, Solidarity, Couchbase,Dataroot and Golang.
4. **Optimal skills:** SQL leads in demand for Data analyst while offering a relatively high salary average and Go leads in high salary average while also having a moderalty high demand count on the job market.

# What I learned
The project helped me immensely improve my SQL skills while at the same time very informative as well. It was a great stepping stone on my path in Data analytics.
