-- Identify the ten highest-paying remote Data Analyst jobs.
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        company.name AS company_name

    -- Join each job posting to its company so the result includes the company name.
    FROM
        job_postings_fact AS job_postings

    LEFT JOIN company_dim AS company
        ON job_postings.company_id = company.company_id

    -- Keep remote Data Analyst postings with a known annual salary.
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL

    -- Rank the jobs by annual salary and retain only the top ten.
    ORDER BY
        salary_year_avg DESC

    LIMIT 10
)

-- Add each skill associated with the selected top-paying jobs.
SELECT
    top_paying_jobs.*,
    skills

FROM top_paying_jobs

-- Use the bridge table to connect each job to its skill IDs.
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id

-- Convert each skill ID into its readable skill name.
INNER JOIN skill_dim AS skills
    ON skills_job_dim.skill_id = skills.skill_id

-- Keep the skills grouped by the salary ranking of their associated job.
ORDER BY
    salary_year_avg DESC;