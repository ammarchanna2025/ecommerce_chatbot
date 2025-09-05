# Small Python base image
FROM python:3.10-slim

# Working directory
WORKDIR /app

# Install system dependencies (for NLP libs like spacy, nltk, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc wget curl \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files (not venv, not cache)
COPY . .

# Download NLP resources if needed (optional)
# Example for nltk:
# RUN python -m nltk.downloader punkt stopwords

# Expose Flask port
EXPOSE 5000

# Run Flask API
CMD ["python", "app.py"]
