-- Categorize Data Analyst jobs by whether they are remote, local to New York,
-- or onsite based on the text stored in the job location column.
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category   
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-- Group Data Analyst jobs into salary bands using the annual salary value.
-- Rows without an annual salary are excluded so they are not classified.
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'Highest Salary'
        WHEN salary_year_avg <= 50000 THEN 'Lowest Salary'
        ELSE 'Standard Salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    number_of_jobs DESC;

-- Return the overall salary range recorded in the job postings table.
SELECT
    MAX(salary_year_avg) AS highest_salary,
    MIN(salary_year_avg) AS lowest_salary
FROM
    job_postings_fact;