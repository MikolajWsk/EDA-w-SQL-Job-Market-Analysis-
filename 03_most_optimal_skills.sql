/*

    Question: What are the most optimal skills for data engineers - balancing both demand and salary?
    - Create a ranking column that combines demand count and median salary to identufy the most valuable skills
    - Focus only on remote Data Engineer positions with specified annual salaries.
    - Why?
        > This aproach highlights skills that balance market demand and financial reward. It weighs core skills appropriately, 
          rather than letting rare, outlier skills distort the results

*/

SELECT
    sd.skills AS skill_name,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)) / 10000, 1) AS ranking,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    ROUND(LN(COUNT(jpf.*)), 2) AS demand_count_ln
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
    AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    ranking DESC
LIMIT 25;

/*

    KEY INSIGHTS: OPTIMAL SKILL VALUE (SALARY × LN(DEMAND))

    - Methodology & Purpose:
      By weighting Median Salary against log-transformed Demand Count [ln(demand_count)], this metric 
      filters out hyper-niche, low-volume skills to highlight technologies that deliver the optimal 
      balance of market stability (high liquidity) and premium compensation.

    - Terraform Takes the Top Spot (#1 Rank, 96.8 Score):
      Terraform balances high market volume with exceptional compensation ($184,000 median salary). 
      It demonstrates that Infrastructure-as-Code (IaC) is no longer just a DevOps skill—it is 
      currently the single most valuable technical lever for data engineers.

    - The Ubiquitous Core (Python & SQL: #2 and #4 Ranks):
      Despite lower raw median salaries relative to niche tools (~$130,000 - $135,000), Python 
      and SQL claim top tier status (94.9 and 91.4 scores) due to overwhelming market demand 
      [ln(demand_count) = 7.03]. They remain mandatory, highly durable foundations for the field.

    - Cloud Platforms & Big Data Ecosystem (AWS, Airflow, Spark, Snowflake):
    - AWS leads all cloud providers (#3 Rank, 91.5 Score), surpassing Azure (78.9) and GCP (71.8).
    - Airflow (#5, 89.3) and Spark (#6, 87.1) solidify their positions as the core engines of modern 
      data orchestration and large-scale distributed computing.
    - Snowflake (#7, 82.4) outperforms alternative cloud data warehouses like Redshift (#15, 73.0) 
      and BigQuery (#25, 65.0) in combined market power.

    - Real-Time & Streaming Infrastructure Commands a Premium:
      Kafka (#8, 82.3 Score, $145,000 median salary) demonstrates strong overall market value, 
      highlighting that event-driven architecture and streaming pipelines rank among the highest-paid 
      specialized domains in data engineering.

    Output:
    ┌────────────┬─────────┬───────────────┬─────────────────┐
    │ skill_name │ ranking │ median_salary │ demand_count_ln │
    │  varchar   │ double  │    double     │     double      │
    ├────────────┼─────────┼───────────────┼─────────────────┤
    │ terraform  │    96.8 │      184000.0 │            5.26 │
    │ python     │    94.9 │      135000.0 │            7.03 │
    │ aws        │    91.5 │      137320.0 │            6.66 │
    │ sql        │    91.4 │      130000.0 │            7.03 │
    │ airflow    │    89.3 │      150000.0 │            5.96 │
    │ spark      │    87.1 │      140000.0 │            6.22 │
    │ snowflake  │    82.4 │      135500.0 │            6.08 │
    │ kafka      │    82.3 │      145000.0 │            5.68 │
    │ azure      │    78.9 │      128000.0 │            6.16 │
    │ java       │    77.1 │      135000.0 │            5.71 │
    │ scala      │    75.6 │      137290.0 │            5.51 │
    │ kubernetes │    75.1 │      150500.0 │            4.99 │
    │ git        │    74.7 │      140000.0 │            5.34 │
    │ databricks │    74.1 │      132750.0 │            5.58 │
    │ redshift   │    73.0 │      130000.0 │            5.61 │
    │ gcp        │    71.8 │      136000.0 │            5.28 │
    │ hadoop     │    71.4 │      135000.0 │            5.29 │
    │ nosql      │    70.7 │      134415.0 │            5.26 │
    │ pyspark    │    70.3 │      140000.0 │            5.02 │
    │ docker     │    67.1 │      135000.0 │            4.97 │
    │ mongodb    │    66.7 │      135750.0 │            4.91 │
    │ go         │    66.2 │      140000.0 │            4.73 │
    │ r          │    65.9 │      134775.0 │            4.89 │
    │ github     │    65.4 │      135000.0 │            4.84 │
    │ bigquery   │    65.0 │      135000.0 │            4.81 │
    └────────────┴─────────┴───────────────┴─────────────────┘
    25 rows                                      4 columns
    
*/