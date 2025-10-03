/*
Question: What are the most optimal skills to learn (skills in high demand and high-paying)
- Identify skills in high demand and link with skills with high paying salaries for Data Analyst
- Focus on remotr positions with specified salaries
why?
Targets skills that offer job security and financial benefits
Offers strategic insights for career development in Data Analysis
*/


With top_demanded_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE  AND 
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    
), top_paying_skills AS (
    SELECT 
        skills_dim.skill_id,
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
        skills_dim.skill_id
)

SELECT
    top_demanded_skills.skill_id,
    top_demanded_skills.skills,
    demand_count,
    average_salary
FROM
    top_demanded_skills
JOIN top_paying_skills
ON top_demanded_skills.skill_id = top_paying_skills.skill_id
WHERE
    demand_count > 10
ORDER BY 
    average_salary DESC,
    demand_count DESC
LIMIT 25;

