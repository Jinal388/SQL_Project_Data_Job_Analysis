-- Average annual salary by skill for Data Analyst roles.
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary

FROM job_postings_fact

-- Match each job to the skills required by that job.
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

-- Replace each skill ID with the skill name.
INNER JOIN skill_dim AS skills
    ON skills_job_dim.skill_id = skills.skill_id

-- Restrict the analysis to Data Analyst jobs with a recorded salary.
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    -- AND job_work_from_home = TRUE

-- Group by skill so we can compute the average salary per skill.
GROUP BY
    skills

-- Sort from the highest-paying skill to the lowest and keep the top 25.
ORDER BY
    avg_salary DESC
LIMIT 25;