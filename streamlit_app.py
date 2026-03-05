import os
import time

import pandas as pd
import snowflake.connector
import streamlit as st
from dotenv import load_dotenv

load_dotenv()


# Snowflake Connection with MFA
def get_conn():
    return snowflake.connector.connect(
        user=os.environ["SNOWFLAKE_USER"],
        account=os.environ["SNOWFLAKE_ACCOUNT"],
        password=os.environ["SNOWFLAKE_PASSWORD"],
        warehouse=os.environ["SNOWFLAKE_WAREHOUSE"],
        database="CS5542_DB",
        schema="APP",
        authenticator="username_password_mfa",  # ✅ Correct spelling
        client_request_mfa_token=True,
        passcode=os.environ.get("SNOWFLAKE_PASSCODE"),  # ✅ Optional MFA passcode
    )


st.title("CS5542 Lab 5 — Snowflake Dashboard")
query_text = st.text_input("Search keyword", "risk")

conn = None
try:
    conn = get_conn()
    cursor = conn.cursor()

    t0 = time.time()

    # ✅ Use cursor.execute() with proper Snowflake parameter binding
    cursor.execute(
        """
        SELECT
            DOC_ID,
            CHUNK_ID,
            CHUNK_INDEX,
            CHUNK_TEXT
        FROM CHUNKS
        WHERE CHUNK_TEXT ILIKE %s
        ORDER BY DOC_ID, CHUNK_INDEX
        LIMIT 50
        """,
        (f"%{query_text}%",),
    )

    # ✅ Convert cursor results to DataFrame
    df = cursor.fetch_pandas_all()
    latency = time.time() - t0

    st.metric("Latency (sec)", round(latency, 3))
    st.metric("Returned rows", len(df))
    st.dataframe(df)

    # Log Query
    try:
        cursor.execute(
            """
            INSERT INTO QUERY_LOGS
            (user_query, generated_sql)
            VALUES (%s, %s)
            """,
            (query_text, "SELECT FROM CHUNKS WHERE CHUNK_TEXT ILIKE ?"),
        )
        conn.commit()
    except Exception as e:
        st.warning(f"Logging failed: {e}")

except Exception as e:
    st.error(f"Database error: {e}")

finally:
    if conn is not None:
        conn.close()
