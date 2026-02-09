FROM python:3.12.3-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Copy dependency files
COPY pyproject.toml poetry.lock* ./

# Install dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --only=main

# Copy application code
COPY src/ ./src/
COPY main.py .
COPY ecosystem.ai.config.js .
COPY run.prod.sh .

# Make scripts executable
RUN chmod +x run.prod.sh

# Expose port
EXPOSE 8000

# Run the application
CMD ["python", "main.py"]