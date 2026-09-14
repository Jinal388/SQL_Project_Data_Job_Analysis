-- CTE 1: Count how often each skill appears in remote Data Analyst jobs.
WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count

    FROM job_postings_fact

    -- Link each job posting to the skills associated with it.
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id

    -- Replace skill IDs with their actual skill names.
    INNER JOIN skill_dim AS skills
        ON skills_job_dim.skill_id = skills.skill_id

    -- Filter to remote Data Analyst jobs that include an annual salary.
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE

    -- Group by skill so each skill has a total demand count.
    GROUP BY
        skills_job_dim.skill_id
),

-- CTE 2: Calculate the average salary for each skill in the same filtered job set.
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        skills.skills,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary

    FROM job_postings_fact

    -- Join job postings to their related skills.
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id

    -- Join skill IDs to the skill names table.
    INNER JOIN skill_dim AS skills
        ON skills_job_dim.skill_id = skills.skill_id

    -- Use the same remote Data Analyst salary filter for consistency.
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE

    -- Group by skill to compute the average salary per skill.
    GROUP BY
        skills_job_dim.skill_id,
        skills.skills
)

-- Final output: combine demand count and average salary for each skill.
SELECT
    skills_demand.skill_id,
    average_salary.skills,
    skills_demand.demand_count,
    average_salary.avg_salary

FROM skills_demand

-- Match the two CTEs on skill_id so both metrics are shown together.
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id

-- Sort by demand so the most common skills appear first.
ORDER BY
    skills_demand.demand_count DESC;