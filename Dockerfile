FROM python:3.9-alpine
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python app.py

##### CMD COMMANDS #####
# docker build -t welcome-app .  : Build the image
# docker image ls : List all images
# docker run -d -p 5000:5000 welcome-app : Run the container in detached mode and map port 5000 of the container to port 5000 of the host
# docker ps : List all running containers
# docker stop <container_id> : Stop the container
# docker rm <container_id> : Remove the container
# docker rmi <image_id> : Remove the image

# docker logs <container_id> : View the logs of the container
# docker exec -it <container_id> sh : Access the container's shell                                                                                          
# docker-compose up : Start the container using docker-compose
# docker-compose down : Stop the container using docker-compose

# docker-compose logs : View the logs of the container using docker-compose
# docker-compose exec <service_name> sh : Access the container's shell using docker-compose
# docker-compose build : Build the container using docker-compose

# docker-compose down --rmi all : Stop the container and remove all images using docker-compose
# docker-compose down --volumes : Stop the container and remove all volumes using docker-compose
# docker-compose down --remove-orphans : Stop the container and remove all orphaned containers using docker-compose 
# docker-compose up --build : Build the container and start it using docker-compose
# docker-compose up -d : Start the container in detached mode using docker-compose

# docker-compose up --force-recreate : Force recreate the container using docker-compose
# docker-compose up --no-deps : Start the container without dependencies using docker-compose
# docker-compose up --scale <service_name>=<number> : Scale the container using docker-compose
# docker-compose up --abort-on-container-exit : Stop the container if any container exits using docker-compose
# docker-compose up --timeout <seconds> : Set the timeout for the container using docker-compose

# docker-compose up --remove-orphans : Remove orphaned containers using docker-compose
# docker-compose up --no-recreate : Start the container without recreating it using docker-compose
# docker-compose up --no-build : Start the container without building it using docker-compose
# docker-compose up --no-start : Start the container without starting it using docker-compose
# docker-compose up --no-deps : Start the container without dependencies using docker-compose

# docker-compose up --no-recreate : Start the container without recreating it using docker-compose
# docker-compose up --no-start : Start the container without starting it using docker-compose
# docker-compose up --no-deps : Start the container without dependencies using docker-compose
# docker-compose up --no-recreate : Start the container without recreating it using docker-compose
# docker-compose up --no-start : Start the container without starting it using docker-compose
# docker-compose up --no-deps : Start the container without dependencies using docker-compose
# docker-compose up --no-recreate : Start the container without recreating it using docker-compose

# docker-compose up --no-start : Start the container without starting it using docker-compose
# docker-compose up --no-deps : Start the container without dependencies using docker-compose
# docker-compose up --no-recreate : Start the container without recreating it using docker-compose
# docker-compose up --no-start : Start the container without starting it using docker-compose


