WITH first_quarter AS (
    SELECT 
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM
        january_job

    UNION ALL

    SELECT 
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM
        february_job

    UNION ALL

    SELECT 
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM
        march_job
)

SELECT * FROM first_quarter
WHERE salary_year_avg > 70000
ORDER BY salary_year_avg;
