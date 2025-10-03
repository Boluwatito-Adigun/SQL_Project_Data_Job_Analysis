/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Dta Analyst position
- Focuses on roles with specified salaries that work from home
why?
It reveals how different skills impact salary levels for Data Analysts and helps indentify the most 
financially rewarding skills to acquire or improve.
*/

SELECT 
   skills,
   ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact
JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY 
    average_salary DESC
LIMIT 25;