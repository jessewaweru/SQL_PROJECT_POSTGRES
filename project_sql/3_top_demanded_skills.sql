--Problem statement: Most in-demand skills for Data Analysts
-- I performed two methods to solve the problem statement above
-- Identified the top 5 skills by their demaind in remote jobs
-- Why? to provide insights into the most sought out skills for Data Analysts in the workplace.

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