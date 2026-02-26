#!/bin/bash
set -e

echo "BeforeInstall: Creating .env file..."
cat > /home/ubuntu/app/.env << 'ENVEOF'
GOOGLE_API_KEY=${GOOGLE_API_KEY}
MONGODB_URI=${MONGODB_URI}
GEMINI_MODEL=${GEMINI_MODEL}
OPENAI_API_KEY=${OPENAI_API_KEY}
LANGFUSE_SECRET_KEY=${LANGFUSE_SECRET_KEY}
LANGFUSE_PUBLIC_KEY=${LANGFUSE_PUBLIC_KEY}
LANGFUSE_BASE_URL=${LANGFUSE_BASE_URL}
AWS_ENDPOINT_URL=${AWS_ENDPOINT_URL}
AWS_REGION=${AWS_REGION}
AWS_BUCKET_NAME=${AWS_BUCKET_NAME}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
LANGSMITH_API_KEY=${LANGSMITH_API_KEY}
OPENROUTER_API_KEY=${OPENROUTER_API_KEY}
OPENROUTER_MODEL=${OPENROUTER_MODEL}
KAFKA_BOOTSTRAP_SERVERS=${KAFKA_BOOTSTRAP_SERVERS}
ENVEOF
chmod 600 /home/ubuntu/app/.env
echo "BeforeInstall: .env file created"

echo "BeforeInstall: Stopping existing containers..."
if [ -d "/home/ubuntu/app" ]; then
    cd /home/ubuntu/app
    sudo docker compose down || true
    sudo docker system prune -f || true

    echo "BeforeInstall: Creating backup of current app..."
    if [ -d "/home/ubuntu/app_backup" ]; then
        sudo rm -rf /home/ubuntu/app_backup
    fi
    sudo cp -r /home/ubuntu/app /home/ubuntu/app_backup
else
    echo "BeforeInstall: No existing app found, skipping..."
fi
