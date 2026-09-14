-- Load company dimension records from the tab-delimited source file.
COPY company_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\company_dim.csv'
DELIMITER E'\t' CSV HEADER;

-- Load job posting fact records from the tab-delimited source file.
COPY job_postings_fact
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\job_postings_fact.csv'
DELIMITER E'\t' CSV HEADER;

-- Load the available skills into the skill dimension.
COPY skill_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\skills_dim.csv'
DELIMITER E'\t' CSV HEADER;

-- Load the job-to-skill relationships.
-- The table's composite key requires each pair to be unique.
COPY skills_job_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\skills_job_dim.csv'
DELIMITER E'\t' CSV HEADER;
