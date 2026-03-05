USE DATABASE CS5542_DB;
USE SCHEMA APP;



CREATE TABLE toyota_stock_prices (
    trade_date DATE,
    open_price FLOAT,
    high_price FLOAT,
    low_price FLOAT,
    close_price FLOAT,
    volume FLOAT
);


CREATE TABLE query_logs (
    log_id INTEGER AUTOINCREMENT,
    user_query STRING,
    generated_sql STRING,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
