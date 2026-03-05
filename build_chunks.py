import os

import pandas as pd
import snowflake.connector
from dotenv import load_dotenv

load_dotenv()

# Connect to Snowflake
conn = snowflake.connector.connect(
    user=os.environ["SNOWFLAKE_USER"],
    account=os.environ["SNOWFLAKE_ACCOUNT"],
    password=os.environ["SNOWFLAKE_PASSWORD"],
    warehouse=os.environ["SNOWFLAKE_WAREHOUSE"],
    database="CS5542_DB",
    schema="APP",
    authenticator="username_password_mfa",  # ✅ Correct spelling
    passcode=os.environ.get("SNOWFLAKE_PASSCODE"),  # ✅ Optional MFA passcode
)

cursor = conn.cursor()

# Load CSV
df = pd.read_csv("data/Toyota_Stock_Prices_1980_2026.csv")


def chunk_text(text, chunk_size=300):
    words = text.split()
    for i in range(0, len(words), chunk_size):
        yield " ".join(words[i : i + chunk_size])


# Build chunks
for _, row in df.iterrows():
    doc_id = str(row["doc_id"])  # adjust if different
    text = row["text"]  # adjust if different

    for idx, chunk in enumerate(chunk_text(text)):
        cursor.execute(
            """
            INSERT INTO CHUNKS (DOC_ID, CHUNK_TEXT, CHUNK_INDEX, META)
            VALUES (%s, %s, %s, OBJECT_CONSTRUCT())
            """,
            (doc_id, chunk, idx),
        )

conn.commit()
cursor.close()
conn.close()

print("Chunks inserted successfully.")
