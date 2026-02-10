FROM python:3.11-slim

WORKDIR /app

# 1. Install common requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Install service-specific requirements
COPY services/iterative_discussion/requirements.txt ./services/iterative_discussion/requirements.txt
RUN pip install --no-cache-dir -r services/iterative_discussion/requirements.txt

# 3. Copy shared and service code
COPY shared/ ./shared/
COPY services/iterative_discussion/ ./services/iterative_discussion/

# 4. Set Python path and run
ENV PYTHONPATH=/app
CMD ["uvicorn", "services.iterative_discussion.app.main:app", "--host", "0.0.0.0", "--port", "8003"]
