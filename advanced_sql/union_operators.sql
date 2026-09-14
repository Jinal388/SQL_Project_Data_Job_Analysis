-- Combine the January, February, and March job tables into one first-quarter result.
-- UNION ALL keeps every posting from each month, including rows with matching values.
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

-- Return first-quarter postings with an average annual salary above $70,000.
-- Sort the results from the lowest qualifying salary to the highest.
SELECT * FROM first_quarter
WHERE salary_year_avg > 70000
ORDER BY salary_year_avg;
