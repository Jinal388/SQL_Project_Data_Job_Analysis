-- Create a separate table containing all job postings added in January.
-- EXTRACT returns the month number from the posting date, where January is 1.
CREATE TABLE january_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


-- Create a separate table containing all job postings added in February.
-- February is identified by month number 2.
CREATE TABLE february_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


-- Create a separate table containing all job postings added in March.
-- March is identified by month number 3.
CREATE TABLE march_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;
