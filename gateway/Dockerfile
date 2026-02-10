FROM python:3.11-slim

WORKDIR /app

# 1. Install common requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Copy shared and service code
COPY shared/ ./shared/
COPY gateway/ ./gateway/

# 4. Set Python path and run
ENV PYTHONPATH=/app
CMD ["uvicorn", "gateway.main:app", "--host", "0.0.0.0", "--port", "8000"]
