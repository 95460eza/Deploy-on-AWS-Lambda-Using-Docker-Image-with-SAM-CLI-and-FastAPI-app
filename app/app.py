
#import os
#import json
#import pandas as pd
#import sklearn
#import joblib
#import numpy
import fastapi
from fastapi import FastAPI
import mangum
from mangum import Mangum

app_test = FastAPI()

# The INDEX (main) page of the EndPoint will return the JSON file below (no INPUT needed)
@app_test.get("/")
def index():
    return {"message": "NATOU mon BEBE. Le MALI gagne!!"}



# By default Uvicorn starts the ASGI application in "DEVELOPMENT" mode. To run Uvicorn in "PRODUCTION" mode, specify the --workers OPTION:  
# uvicorn.run(app, host="0.0.0.0", port=8000, workers=4). Here we ask Uvicorn to start 4 worker processes in Production to handle concurrent requests efficiently.
# In production, we commonly use a "PROCESS MANAGER" like Gunicorn in conjunction with Uvicorn for deploying ASGI applications. Gunicorn can spawn multiple Uvicorn worker processes 
# gunicorn -w 4 -k uvicorn.workers.UvicornWorker myapp:app
# The command ABOVE starts Gunicorn with 4 worker processes, each running Uvicorn to handle ASGI request
# if __name__ == '__main__':
#     import uvicorn
#     uvicorn.run(app_test,  port=8000)


mangum_handler = Mangum(app_test)

