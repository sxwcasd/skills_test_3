# Use an official Python image as the base image
FROM python:3.9-slim
USER root
# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file to the container (optional if you prefer specifying packages here)
COPY /mnt/SCRATCH/linghao/cerc_assignment/skills_test_3_linghao/bin/requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Optionally, copy your application code to the container
# COPY . .

# Command to keep the container running (replace with your app's start command if needed)
CMD ["python3"]
