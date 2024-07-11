--Find the count of the number of remote job postings per skill
---Display the top 5 skills by their demaind in remote jobs
---Include skills ID,name,and count of postings requiring the skill

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