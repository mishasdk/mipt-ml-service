import os
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()


app = FastAPI()
VERSION = os.getenv("SERVICE_VERSION", "unknown")


@app.get("/health")
def health():
    return {"status": "ok", "version": VERSION}


if __name__ == "__main__":
    import uvicorn
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
