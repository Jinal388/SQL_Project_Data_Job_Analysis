COPY company_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\company_dim.csv'
DELIMITER E'\t' CSV HEADER;

COPY job_postings_fact
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\job_postings_fact.csv'
DELIMITER E'\t' CSV HEADER;

COPY skill_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\skills_dim.csv'
DELIMITER E'\t' CSV HEADER;

COPY skills_job_dim
FROM 'D:\Data Analysis\SQL_Project_Data_Job_Analysis\csv_files\skills_job_dim.csv'
DELIMITER E'\t' CSV HEADER;
