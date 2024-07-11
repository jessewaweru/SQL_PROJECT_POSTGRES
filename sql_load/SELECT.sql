SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM
    january_jobs
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'


UNION ALL

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM
    february_jobs
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'

UNION ALL

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM
    march_jobs
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'


ORDER BY
    salary_year_avg DESC;

