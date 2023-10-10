FROM python:3.8.5-slim-buster

FROM ubuntu:20.04

# Set JAVA_HOME and install OpenJDK 8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN apt-get update -y \
    && apt-get install -y openjdk-8-jdk \
    && apt-get install python3-pip -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for your application
ENV AIRFLOW_HOME="/app/airflow"
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3

# Create a directory for your application and set it as the working directory
RUN mkdir /app
COPY . /app/
WORKDIR /app/

# Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Set the entry point to run your app.py script
CMD ["python3", "app.py"]
