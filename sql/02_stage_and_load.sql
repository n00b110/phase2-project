-- ============================================================
-- 02_stage_and_load.sql — Warehouse, file format, internal stage
-- ============================================================
-- Run this script SECOND (after 01_create_schema.sql).
-- It sets up the compute warehouse, a reusable CSV file format,
-- and an internal stage where local files are uploaded before
-- being loaded into tables with COPY INTO.
--
-- References:
--   • CREATE WAREHOUSE:    https://docs.snowflake.com/en/sql-reference/sql/create-warehouse
--   • CREATE FILE FORMAT:  https://docs.snowflake.com/en/sql-reference/sql/create-file-format
--   • CREATE STAGE:        https://docs.snowflake.com/en/sql-reference/sql/create-stage
--   • COPY INTO <table>:   https://docs.snowflake.com/en/sql-reference/sql/copy-into-table
-- ============================================================

-- 1. Compute warehouse (XSMALL is cheapest; auto-suspends after 60s idle).
CREATE OR REPLACE WAREHOUSE INSTRUCTOR2_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

USE WAREHOUSE INSTRUCTOR2_WH;
USE DATABASE INSTRUCTOR2_DB;
USE SCHEMA MY_SCHEMA;

-- 2. CSV file format — matches the header row / quoting in data/*.csv.
CREATE OR REPLACE FILE FORMAT CS5542_CSV_FMT
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'null');

-- 3. Internal stage — a Snowflake-managed storage area where files
--    are uploaded before being loaded into tables.
CREATE OR REPLACE STAGE CS5542_STAGE
  FILE_FORMAT = CS5542_CSV_FMT;

-- 4. After uploading a file to the stage (via PUT or the Python loader
--    script), run COPY INTO to load it into the target table:
--
--    COPY INTO EVENTS
--    FROM @CS5542_STAGE/events.csv
--    ON_ERROR = 'CONTINUE';
--
--    Tip: ON_ERROR = 'CONTINUE' skips bad rows instead of failing
--    the entire load.  Change to 'ABORT_STATEMENT' for stricter
--    validation once your data pipeline is stable.
