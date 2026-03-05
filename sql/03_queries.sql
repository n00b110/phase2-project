USE DATABASE CS5542_DB;
USE SCHEMA APP;

-- Total records
SELECT COUNT(*) FROM toyota_stock_prices;

-- Highest closing price
SELECT MAX(close_price) FROM toyota_stock_prices;

-- Average closing price by year
SELECT YEAR(trade_date) AS year,
       AVG(close_price) AS avg_price
FROM toyota_stock_prices
GROUP BY year
ORDER BY year;

-- Year with highest average price
SELECT YEAR(trade_date) AS year,
       AVG(close_price) AS avg_price
FROM toyota_stock_prices
GROUP BY year
ORDER BY avg_price DESC
LIMIT 1;

-- Total volume by year
SELECT YEAR(trade_date) AS year,
       SUM(volume) AS total_volume
FROM toyota_stock_prices
GROUP BY year
ORDER BY year;
