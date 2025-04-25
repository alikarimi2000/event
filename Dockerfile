# Step 1: Use the official Python image as a base image
FROM python:3.10-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements file (if you have one, we'll add it shortly)
COPY req.txt .

# Step 4: Install the dependencies
RUN pip install --no-cache-dir -r req.txt

# Step 5: Copy the rest of the application code into the container
COPY . .

# Step 6: Expose the port that Flask will run on (default is 5000)
EXPOSE 5000

# Step 7: Set the environment variable to tell Flask to run in production mode
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Step 8: Command to run the Flask app inside the container
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

