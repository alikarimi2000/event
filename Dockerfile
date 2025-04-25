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

# Copy requirements file first for better caching
COPY req.txt ./req.txt

# Install Python dependencies (make sure gunicorn is in req.txt)
RUN pip install --no-cache-dir -r req.txt

# Copy the rest of the application code
COPY . .

# Expose the port your app will run on
EXPOSE 5000

# Start the app using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
