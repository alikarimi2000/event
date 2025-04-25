FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy application code
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir Flask pony flask-cors psycopg2-binary

# Expose the Flask port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]


