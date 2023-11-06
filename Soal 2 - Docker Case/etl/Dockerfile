FROM python:3.11

# Install the required Python packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the ETL script to the container
COPY etl.py .

# Define the environment variable for the API URL
ENV API_URL http://api:6000/predict

# Run the ETL script
CMD ["python", "etl.py"]