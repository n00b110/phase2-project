###Multimodal Statistical Learning RAG System

CS 5542 – Phase 2 Project

Project Overview

This project implements a multimodal Retrieval-Augmented Generation (RAG) system based on lecture materials from COMP-SCI-5565: Introduction to Statistical Learning.

The goal of the system is to retrieve relevant information from course lecture PDFs and related machine learning diagrams in response to user queries. The system combines dense retrieval, sparse retrieval, multimodal fusion, reranking, and Snowflake logging into a reproducible end-to-end pipeline.

The project builds on Labs 1–5 completed throughout the semester.

System Architecture

The system follows this overall flow:

Data Sources → Multimodal Knowledge Base → Hybrid Retrieval Pipeline → Snowflake → Streamlit Application

The implementation builds progressively on earlier labs:

Lab 1: Embeddings and similarity search

Lab 2: Advanced RAG (chunking and dense retrieval)

Lab 3: Multimodal retrieval and hybrid scoring

Lab 4: Streamlit application integration

Lab 5: Snowflake data pipeline

Dataset

The knowledge base includes both text and image data.

PDFs (data/pdfs/)

Nine lecture documents covering major topics in statistical learning, including:

Linear Regression

Classification

Resampling Methods

Regularization

Tree-Based Methods

Support Vector Machines

Unsupervised Learning

Deep Learning

These documents are used for text extraction, chunking, embedding generation, and retrieval.

Images (data/images/)

The dataset also includes several machine learning-related diagrams such as:

Regression visualizations

Optimization update diagrams

Model comparison examples

Regression loss surface visualizations

Images are processed using descriptive filenames, OCR extraction (Tesseract), and TF-IDF indexing.

No sampling was performed. All available materials were included to preserve full coverage of the course content.

Retrieval Pipeline
Chunking

Two chunking strategies are implemented:

Fixed-size chunking (1200 characters with 200-character overlap)

Semantic paragraph-based chunking

This allows comparison of how chunk structure affects retrieval performance.

Dense Retrieval

SentenceTransformer model: all-MiniLM-L6-v2

FAISS vector index

Dense retrieval captures semantic similarity between queries and document chunks.

Sparse Retrieval

BM25 keyword-based ranking

Sparse retrieval helps capture exact term matches.

Image Retrieval

TF-IDF indexing on image captions and OCR-extracted text

Hybrid Fusion

Text and image scores are combined using a weighted scoring approach to balance semantic and keyword relevance.

Reranking

CrossEncoder model: ms-marco-MiniLM-L-6-v2

Reranking refines the final ranking of retrieved results.

Evaluation Metrics

Retrieval performance is evaluated using:

Precision@5

Recall@10

Comparisons are made across chunking strategies and retrieval configurations.

Application

The system includes a Streamlit interface that:

Accepts user queries

Displays retrieved text evidence

Displays relevant images when appropriate

Logs query results

Snowflake Integration

Snowflake is used to support:

Metadata storage

Query logging

Retrieval result tracking

Warehouse-level analysis

Schema definitions and SQL scripts are located in the snowflake/ directory.

Reproducibility

To reproduce the system:

Clone the repository

Install dependencies:

pip install -r requirements.txt

Install Tesseract OCR

Run ingestion and index-building scripts

Launch the Streamlit application:

streamlit run application/app.py

All models and configuration settings are included in the repository.

Repository Structure
data/
   pdfs/
   images/
ingestion/
retrieval/
application/
snowflake/
reproducibility/
docs/

Team Members: Ibrahim Alborno and Immanuel

(Add team member names here)

Contributions

See CONTRIBUTIONS.md for individual technical contributions and percentage breakdown.
