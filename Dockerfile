# Use official slim Python runtime as a parent image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install OS-level dependencies for psycopg2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements file first for better caching
COPY req.txt /app/req.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r /app/req.txt

# Copy application code
COPY . /app

# Expose the Flask default port
EXPOSE 5000

# Run the Flask application
CMD ["python", "app.py"]