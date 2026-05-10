import os
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()


app = FastAPI()
VERSION = os.getenv("SERVICE_VERSION", "unknown")


@app.get("/health")
def health():
    return {"status": "ok", "version": VERSION}
