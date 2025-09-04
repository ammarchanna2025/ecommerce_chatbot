# 1. Use a smaller base image
FROM python:3.10-slim-bookworm

# Set the working directory
WORKDIR /app

# Copy only the requirements file first to leverage Docker caching
COPY requirements.txt .

# 2. Install dependencies and then immediately clean up the cache
#    This keeps the layer size down.
RUN pip install --no-cache-dir -r requirements.txt && pip cache purge

# Copy the rest of your application code
COPY . .

# Command to run your application
CMD ["python", "app.py"]