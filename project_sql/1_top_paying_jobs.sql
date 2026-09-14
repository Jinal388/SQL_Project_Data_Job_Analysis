-- Return the ten highest-paying remote Data Analyst jobs.
SELECT
    job_id,
    job_title,
    company.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date

-- Start with job posting details and add the related company name.
FROM
    job_postings_fact AS job_postings

LEFT JOIN company_dim as company ON job_postings.company_id = company.company_id

-- Keep remote Data Analyst jobs that include an annual salary.
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

-- Rank the remaining jobs from highest to lowest salary and return the top ten.
ORDER BY
    salary_year_avg DESC

LIMIT 10;
