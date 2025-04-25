# 1. Base image: Python 3.9 slim for a minimal footprint
FROM python:3.9-slim

# 2. Set working directory inside the container
WORKDIR /app

# 3. Copy your application code and templates into the image
COPY . /app

# 4. Install system‐level dependencies needed by psycopg2
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      gcc \
      libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# 5. Install Python dependencies
RUN pip install --no-cache-dir \
      flask \
      flask-cors \
      pony \
      psycopg2-binary

# 6. Expose the port that your Flask app listens on
EXPOSE 5000

# 7. Default command to run your application
CMD ["python", "app.py"]
