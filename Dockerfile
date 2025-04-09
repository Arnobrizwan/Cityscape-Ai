# Use official Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy all files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install dotenv package (if not already in your requirements.txt)
RUN pip install python-dotenv

# Optional: expose a port if running a web server
EXPOSE 8000

# Run the chatbot script
CMD ["python", "ml_server.py"]