# Choose the Python 3.12 "base image" FOR THE AWS LAMBDA FUNCTION from the public AWS ECR image repository. 
FROM public.ecr.aws/lambda/python:3.12

# First copy ONLY the requirements.txt  to leverage Docker cache
# Copy FROM (Relative to the Dockerfile location) .... INTO a folder TO BE created (here called app) INSIDE the Docker Image (Destination)
# This COPIES the FILE from the app FOLDER INTO a LOCATION that will be assigned at DEPLOYMENT by AWS (i.e. it is an  AWS managed ENVIRONMENTAL VARIABLE)
COPY app/requirements.txt   ${LAMBDA_TASK_ROOT}

# install INSIDE THE CONTAINER the dependencies found in requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade mangum

# Copy ALL content FROM (Relative to Dockerfile location).... INTO the work directory /app INSIDE the Docker Image (Destination)
COPY /app   ${LAMBDA_TASK_ROOT}

# Specify the port number the container should expose
# When deploying a containerized application to AWS Lambda, you don't need to worry about EXPOSING ports. If your containerized application uses a web framework like Flask or FastAPI, it
# typically listens on a specific port WITHIN the container BUT Lambda integration with API Gateway takes care of routing the HTTP requests to your Lambda function.
#EXPOSE 8000

# Set the CMD to your HANDLER FUNCTION DEFINED called lambda_handler inside app.py file (could be a parameter override not in the Dockerfile)
#CMD ["python", "/app/app.lambda_handler"]
CMD [ "app.mangum_handler" ]                 
