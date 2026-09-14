-- Count how often each skill appears across Data Analyst job postings.
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count

    FROM
        skills_job_dim AS skills_to_job

    -- Connect each job-skill row back to its job posting.
    INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id

    -- Restrict the analysis to Data Analyst listings.
    WHERE
        job_postings.job_title_short = 'Data Analyst'

    GROUP BY
        skill_id
)

-- Attach each skill ID to its name and return the most in-demand skills.
SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count

FROM remote_job_skills

-- Look up the readable skill name from the skill dimension table.
INNER JOIN skill_dim AS skills
    ON skills.skill_id = remote_job_skills.skill_id

-- Highest-frequency skills appear first; limit to the top five.
ORDER BY
    skill_count DESC
LIMIT 5;

/** Ouput 
[
  {
    "skill_id": 2,
    "skill_name": "sql",
    "skill_count": "5145"
  },
  {
    "skill_id": 157,
    "skill_name": "excel",
    "skill_count": "3953"
  },
  {
    "skill_id": 0,
    "skill_name": "python",
    "skill_count": "2842"
  },
  {
    "skill_id": 160,
    "skill_name": "tableau",
    "skill_count": "2799"
  },
  {
    "skill_id": 156,
    "skill_name": "power bi",
    "skill_count": "1674"
  }
]
**/