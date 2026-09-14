-- Store the companies associated with job postings.
CREATE TABLE public.company_dim
(
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

-- Store the skills that can be linked to job postings.
CREATE TABLE public.skill_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

-- Store the main job posting details and company relationship.
CREATE TABLE public.job_postings_fact
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_loaction TEXT,
    job_posted_date DATE,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES company_dim(company_id)
);

-- Bridge table that links jobs to their required skills.
-- The composite primary key prevents duplicate job-skill pairs.
CREATE TABLE public.skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES job_postings_fact(job_id),
    FOREIGN KEY (skill_id) REFERENCES skill_dim(skill_id)
);

-- Assign table ownership to the PostgreSQL administrator role.
ALTER TABLE public.job_postings_fact OWNER TO postgres;
ALTER TABLE public.company_dim OWNER TO postgres;
ALTER TABLE public.skill_dim OWNER TO postgres;
ALTER TABLE public.skills_job_dim OWNER TO postgres;

-- Index foreign-key columns to improve joins and relationship lookups.
CREATE INDEX idx_company_id ON public.job_postings_fact(company_id);
CREATE INDEX idx_job_id ON public.skills_job_dim(job_id);
CREATE INDEX idx_skill_id ON public.skills_job_dim(skill_id);