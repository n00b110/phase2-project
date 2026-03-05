# CS 5542 – Phase 2  
## Snowflake-Integrated Financial Analytics Pipeline

### Team Members
- Ibrahim Alborno  
- Immanuel Olaoye

---

# Project Overview

This project implements a fully reproducible end-to-end data analytics pipeline integrating:

**Local Structured Data → Snowflake Data Warehouse → Streamlit Application → Query Logging**

The system demonstrates how structured financial data can be ingested into Snowflake, queried using SQL, and accessed through an interactive Streamlit interface.

The dataset used in this project is historical Toyota stock price data (1980–2026), stored locally as a CSV file and loaded into Snowflake for warehouse-level analytics.

---

# Repository Structure

```
phase2-project-main_2/
│
├── data/
│   └── Toyota_Stock_Prices_1980_2026.csv
│
├── logs/
│   └── pipeline_logs.csv
│
├── notebooks/
│   └── week5_snowflake_pipeline.ipynb
│
├── scripts/
│   ├── load_local_csv_to_stage.py
│   └── sf_connect.py
│
├── sql/
│   ├── 01_create_schema.sql
│   ├── 02_stage_and_load.sql
│   └── 03_queries.sql
│
├── streamlit_app.py
├── build_chunks.py
├── requirements.txt
├── CONTRIBUTIONS.md
└── README.md
```

---

# Dataset Description

**Dataset:** Toyota Stock Prices (1980–2026)  
**Format:** CSV (Structured Tabular Data)

The dataset includes:

- Date  
- Open Price  
- High Price  
- Low Price  
- Close Price  
- Volume  

This structured dataset supports time-series analysis and warehouse-driven analytics.

The dataset is stored in:

```
data/Toyota_Stock_Prices_1980_2026.csv
```

---

# Snowflake Data Pipeline

The project implements a reproducible Snowflake ingestion workflow:

1. Create database and schema  
2. Create structured stock price table  
3. Stage CSV data  
4. Load staged data into Snowflake  
5. Execute analytical queries  

SQL scripts are located in the `sql/` directory:

- `01_create_schema.sql` – Creates database, schema, and tables  
- `02_stage_and_load.sql` – Creates stage and loads CSV data  
- `03_queries.sql` – Example analytical queries  

---

# Application Integration

The project includes a Streamlit-based application:

```
streamlit_app.py
```

The application:

- Connects to Snowflake  
- Executes analytical SQL queries  
- Displays stock price data  
- Logs query activity  

User queries and results are recorded in:

```
logs/pipeline_logs.csv
```

This ensures traceability and reproducibility of application interactions.

---

# System Architecture

Pipeline Flow:

Local CSV Data  
↓  
Snowflake Stage  
↓  
Snowflake Tables  
↓  
SQL Analytics  
↓  
Streamlit Application  
↓  
Query Logging  

This architecture separates ingestion, warehousing, analytics, and user interaction layers.

---

# Reproducibility Instructions

## 1. Clone the Repository

```bash
git clone <repository-url>
cd phase2-project-main_2
```

---

## 2. Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 3. Configure Snowflake Credentials

Update your Snowflake credentials inside:

```
scripts/sf_connect.py
```

---

## 4. Run Snowflake Schema & Ingestion Scripts

Execute the following SQL files inside Snowflake (via Snowsight or SnowSQL):

1. `01_create_schema.sql`
2. `02_stage_and_load.sql`

This will:

- Create database and tables
- Stage the CSV file
- Load the data into Snowflake

---

## 5. Launch the Streamlit Application

```bash
streamlit run streamlit_app.py
```

The application will connect to Snowflake and allow interactive querying.

---

# Dependencies

Core libraries include:

- streamlit  
- snowflake-connector-python  
- pandas  
- numpy  

All required libraries are listed in `requirements.txt`.

---

# Reproducibility Notes

- All SQL scripts required for schema creation and ingestion are included.
- The dataset is stored locally under `data/`.
- Logging ensures traceability of executed queries.
- The entire pipeline can be reproduced from ingestion to application.

---

# Contribution Transparency

See `CONTRIBUTIONS.md` for a detailed breakdown of responsibilities.

Contribution split:

- Ibrahim Alborno – 50%  
- Immanuel Olaoye – 50%  

Total: 100%

---

# Phase 2 Deliverables Included

- Snowflake schema scripts  
- Data ingestion pipeline  
- Streamlit application prototype  
- Query logging system  
- Reproducibility instructions  
- Contribution documentation  

This repository represents a fully reproducible Snowflake-integrated analytics pipeline built as part of CS 5542 Phase 2.
