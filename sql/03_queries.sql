-- ============================================================
-- 03_queries.sql — Example analytical queries
-- ============================================================
-- These are the same queries surfaced in the Streamlit dashboard
-- (app/streamlit_app.py).  Run them here in a worksheet if you
-- want to explore results before building UI.
--
-- References:
--   • Aggregate functions: https://docs.snowflake.com/en/sql-reference/functions-aggregation
--   • DATEADD:             https://docs.snowflake.com/en/sql-reference/functions/dateadd
--   • JOIN:                https://docs.snowflake.com/en/sql-reference/constructs/join
-- ============================================================

USE DATABASE INSTRUCTOR2_DB;
USE SCHEMA MY_SCHEMA;

-- Q1: Basic aggregation — count events and average value per team × category.
--     Useful for spotting which teams are most active in each category.
SELECT TEAM, CATEGORY, COUNT(*) AS N, AVG(VALUE) AS AVG_VALUE
FROM EVENTS
GROUP BY TEAM, CATEGORY
ORDER BY N DESC;

-- Q2: Rolling 24-hour window — which categories have the most recent activity?
--     DATEADD('hour', -24, CURRENT_TIMESTAMP()) computes "24 hours ago".
SELECT CATEGORY, COUNT(*) AS N_24H
FROM EVENTS
WHERE EVENT_TIME >= DATEADD('hour', -24, CURRENT_TIMESTAMP())
GROUP BY CATEGORY
ORDER BY N_24H DESC
LIMIT 10;

-- Q3: JOIN users ↔ events — attribute event categories to user roles.
--     The join key is TEAM (both tables share this column).
SELECT U.TEAM, U.ROLE, E.CATEGORY, COUNT(*) AS N
FROM USERS U
JOIN EVENTS E
  ON U.TEAM = E.TEAM
GROUP BY U.TEAM, U.ROLE, E.CATEGORY
ORDER BY N DESC;
