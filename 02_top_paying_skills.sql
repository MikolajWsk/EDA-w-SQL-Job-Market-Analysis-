/*

    Question: What are the highest-paying skills for data engineers
    - Calculate the median salary for each skill required in data engineer posititons
    - Focus on remote jobs with specified salaries
    - Include skill frequency to identify both salary and demand
    - Why?
        > Helps identify which skills command the highest compensation while also showing how common those skills are,
          providing a more complete picture for skill development priorities.
        > The median is used instead of the average to reduce the impact of outlier salaries.

*/


SELECT
    sd.skills AS skill_name,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND
    jpf.job_work_from_home = True
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*

    Key Insights

    - Rust leads the salary board by a wide margin: Garnering a median salary of $210,000, Rust commands a significant premium over all other technologies (~$26,000 higher than the runner-up), 
    reflecting growing industry demand for high-performance, memory-safe systems programming in modern data engines.
    - Low-level and systems languages dominate top-tier compensation: Systems programming languages like Rust ($210,000), Go/Golang ($184,000), and C ($151,500) consistently appear near the top of the pay scale, 
    signaling that data engineering roles involving core infrastructure, custom execution engines, and internal tooling command higher pay than general data manipulation roles.
    - High volume vs. top dollar (The Sweet Spot): 
        > Airflow stands out as the ultimate industry standard: it appears in nearly 10,000 job postings (9,996) while maintaining a strong $150,000 median salary.
        > Kubernetes (4,202 postings at $150,500) and Terraform (3,248 postings at $184,000) highlight that modern data engineers are heavily expected to manage Cloud Infrastructure-as-Code (IaC) and container orchestration.
    - Niche specialty platforms pay premium rates: Specialized tools like Neo4j (Graph Database at $170,000) and specialized compliance/governance standards like GDPR ($169,616) boast high pay, indicating that niche domain knowledge yields high compensation despite lower posting volumes.

    Output:
    ┌────────────┬───────────────┬──────────────┐
    │ skill_name │ median_salary │ demand_count │
    │  varchar   │    double     │    int64     │
    ├────────────┼───────────────┼──────────────┤
    │ rust       │      210000.0 │          232 │
    │ golang     │      184000.0 │          912 │
    │ terraform  │      184000.0 │         3248 │
    │ spring     │      175500.0 │          364 │
    │ neo4j      │      170000.0 │          277 │
    │ gdpr       │      169616.0 │          582 │
    │ zoom       │      168438.0 │          127 │
    │ graphql    │      167500.0 │          445 │
    │ mongo      │      162250.0 │          265 │
    │ fastapi    │      157500.0 │          204 │
    │ bitbucket  │      155000.0 │          478 │
    │ django     │      155000.0 │          265 │
    │ crystal    │      154224.0 │          129 │
    │ atlassian  │      151500.0 │          249 │
    │ c          │      151500.0 │          444 │
    │ typescript │      151000.0 │          388 │
    │ kubernetes │      150500.0 │         4202 │
    │ airflow    │      150000.0 │         9996 │
    │ css        │      150000.0 │          262 │
    │ ruby       │      150000.0 │          736 │
    │ node       │      150000.0 │          179 │
    │ redis      │      149000.0 │          605 │
    │ ansible    │      148798.0 │          475 │
    │ vmware     │      148798.0 │          136 │
    │ jupyter    │      147500.0 │          400 │
    └────────────┴───────────────┴──────────────┘
    25 rows                         3 columns

*/