WITH april_jobs AS(
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 4
)
SELECT
    *
FROM
    april_jobs;