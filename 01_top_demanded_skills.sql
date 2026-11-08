/*

    Question: What are the most in-demand skills for data engineers?
    - Identify the top 10 in-demand skills for data engineers
    - Focus on jobs in Warsaw, Poland
    - Why? Retrieves the top 10 skills with the highest demand in the polish job market,
      providing insights into the most valuable skills in data engineers seeking work

*/

SELECT
    sd.skills AS skill_name,
    COUNT(jpf.*) AS demand_count,
    ANY_VALUE(sd.type) AS skill_type
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_location LIKE '%Warsaw%'
    AND jpf.job_title_short = 'Data Engineer'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*

    Here is a breakdown of the most demanded skills in the data engineerig in Warsaw, Poland:
    Python and SQL are by far the most demanded skills in this profession with ~1,300 postings each. Although this query filtered for jobs in Warsaw, this is a common thing anywhere in the world.
    The TOP 3 is completed by apache spark, an open-source analytics engine. Right outside of TOP 3 there are cloud services, that are important for performing lots of calculations and in-cloud data storage.

    Key takeways:
     - Python and SQL are the base skills for data engineers
     - Tools like Spark continued to be valued as a big data tools
     - A significant portion of modern data engineering involves using cloud platforms

    ┌────────────┬──────────────┬─────────────┐
    │ skill_name │ demand_count │ skill_type  │
    │  varchar   │    int64     │   varchar   │
    ├────────────┼──────────────┼─────────────┤
    │ python     │         1314 │ programming │
    │ sql        │         1246 │ programming │
    │ spark      │          782 │ libraries   │
    │ azure      │          738 │ cloud       │
    │ aws        │          565 │ cloud       │
    │ java       │          500 │ programming │
    │ scala      │          462 │ programming │
    │ hadoop     │          417 │ libraries   │
    │ gcp        │          399 │ cloud       │
    │ airflow    │          383 │ libraries   │
    └────────────┴──────────────┴─────────────┘
    10 rows                       3 columns
    
*/