/*
Question: What are the most in-demand skills for data analysts?

- Join Job_postings_fact table to the skills_job_dim and skills_dim using query 2 as reference
- Identify the top 5  in-demand skills for a data analyst
- Focus on all job postings

Why?
Retrieving the top 5 skills with the highest demand in the job market provides insights
into the most valuable skills for job seekers.

*/

SELECT 
   skills,
   COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;


