USE DATABASE CS5542_DB;
USE SCHEMA APP;

CREATE OR REPLACE STAGE toyota_stage;

COPY INTO toyota_stock_prices
FROM @toyota_stage/Toyota_Stock_Prices_1980_2026.csv
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);
