# EDA w/ SQL: Job Market Analysis

![Project Overview](Images/1_1_Project1_EDA.png)

An SQL project analyzing the data engineer job market (in Warsaw and remote work opportunities) using real world job posting data.

## Executive Summary

- **Project scopes:** Built 3 analytical queries to anwser key questions about the data engineering job market
- **Data modeling:** Used multi-table joins across fact and dimension tables to extract key insights
- **Analytics:** Applied aggregation, filtering and sorting to find top skills by demand, salary, and overall value
- **Outcomes:** Delivered insights into skills and technologies trending in the data engineering market showing which skills are the all time useful and which are coming on the rise.

**Query structure:**
1. [`01_top_demanded_skills.sql`](01_top_demanded_skills.sql) - demand analysis in Warsaw with multi-table joins
2. [`02_top_paying_skills.sql`](02_top_paying_skills.sql) - remote work salary analysis with aggregation
3. [`03_most_optimal_skills.sql`](03_most_optimal_skills.sql) - developing a ranking metric to optimize balancing out demand and salary

## Problem & Context

Job market analysts need to anwser questions like:
- **Most in-demand:** *Which skills are the most in-demand for data engineers?*
- **Highest paid:** *Which skills command the highest salaries?*
- **Best trade-off:** *Which skills are the most valuable to learn?*

This project analyzes a data warehouse built using a star schema design. The warehouse stracture consists of:
![Data Warehouse](Images/1_2_Data_Warehouse.png)

- **Fact table:** `job_postings_fact` - Central table containing job posting details, like: job titles, locations, salaries, dates, etc.
- **Dimension tables:**
    - `company_dim` - Company information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns and optimal skill combinations for data enineering roles.

## Tech Stack

- **Query Engine:** DuckDB for fast OLAP-style analytical queries
- **Language:** SQL (ANSI-style with analytical functions)
- **Data Model:** Star schema with fact + dimension + bridge tables
- **Development:** VSCode for SQL editing + Terminal for DuckDB CLI
- **Version Control:** Git/Github for versioned SQL scripts

## Analysis Overview

### Key insights

- **Core Languages:** SQL and Python each appear in ~1,300 job postings just in Warsaw, and are the most widely demanded skills for data engineers
- **Cloud Platforms:** AWS and Azure are critial for modern data engineering roles
- **Infra & Tooling:** Kubernetes, Docker and Terraform are assosiated with premium salaries
- **Big Data Tools:** Apache Spark shows strong demand with competetive compensation