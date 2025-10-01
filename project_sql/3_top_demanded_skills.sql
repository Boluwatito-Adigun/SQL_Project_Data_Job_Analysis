SELECT 
   *
FROM job_postings_fact
JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
LIMIT 5;