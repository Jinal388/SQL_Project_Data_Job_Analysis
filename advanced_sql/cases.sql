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

SELECT
    MAX(salary_year_avg) AS highest_salary,
    MIN(salary_year_avg) AS lowest_salary
FROM
    job_postings_fact;