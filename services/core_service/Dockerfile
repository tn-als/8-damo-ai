FROM python:3.11-slim

WORKDIR /app

# 1. Install common requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Install service-specific requirements
COPY services/core_service/requirements.txt ./services/core_service/requirements.txt
RUN pip install --no-cache-dir -r services/core_service/requirements.txt

# 3. Copy shared and service code
COPY shared/ ./shared/
COPY services/core_service/ ./services/core_service/

# 4. Set Python path and run
ENV PYTHONPATH=/app
CMD ["uvicorn", "services.core_service.app.main:app", "--host", "0.0.0.0", "--port", "8001"]
