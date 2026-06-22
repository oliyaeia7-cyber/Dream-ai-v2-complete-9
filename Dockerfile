# Dockerfile for DreamWeave AI - Ready for Render Docker Deploy
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies (if needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY app.py .

# Expose port (Render will use $PORT)
EXPOSE 8000

# Command to run the app (Render automatically provides $PORT)
CMD uvicorn app:app --host 0.0.0.0 --port $PORT