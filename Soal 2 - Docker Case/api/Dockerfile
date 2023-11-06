FROM python:3.11

# Install the required Python packages
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the API script to the container
COPY api.py .

# Expose the API endpoint
EXPOSE 6000

# Start the API server
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "6000"]