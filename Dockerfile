# Use Python 3.9 image
FROM python:3.9

# Set working directory inside the container
WORKDIR /app/backend

# Copy the requirements.txt file into the container
COPY requirements.txt /app/backend

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/backend

# Expose port 8000 for the Django app
EXPOSE 8000

# Run Django migrations and start the server
CMD python manage.py migrate && python manage.py runserver 0.0.0.0:8001
