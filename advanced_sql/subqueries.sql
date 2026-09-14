-- Count the skills requested by remote Data Analyst job postings.
-- The CTE performs the aggregation before skill names are joined in below.
WITH remote_job_skills AS (
    SELECT
        skills_to_job.skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN
        job_postings_fact AS job_postings
    ON
        skills_to_job.job_id = job_postings.job_id
    WHERE
        -- Restrict the analysis to remote Data Analyst postings.
        job_postings.job_work_from_home = true AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skills_to_job.skill_id
)

-- Match each skill ID to its readable name and return the ten most requested skills.
SELECT 
    remote_job_skills.skill_id,
    remote_job_skills.skill_count,
    skills.skills AS skill_name
FROM remote_job_skills
INNER JOIN 
    skill_dim AS skills
ON
    remote_job_skills.skill_id = skills.skill_id
ORDER BY
    -- Highest skill counts appear first so LIMIT returns the top ten.
    remote_job_skills.skill_count DESC
LIMIT 10;