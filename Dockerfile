#Use the official Python image as a base image
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /code

# Set the environment variable for Flask app
ENV FLASK_APP=app.py 

# Allow external access
ENV FLASK_RUN_HOST=0.0.0.0 

# Copy the current directory contents into the container at /code
COPY . . 

# Install dependencies
RUN pip install -r requirements.txt 

#Expose port 5000 for Flask
EXPOSE 5000

# Run the Flask app
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

