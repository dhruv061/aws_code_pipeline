#!/bin/bash

echo "🔄 Starting deployment script..."

# Load NVM and set node version
echo "📦 Loading NVM..."
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "🔧 Using Node version v20.18.0..."
nvm use v20.18.0

# Add node binaries to PATH explicitly
echo "🛠️ Updating PATH for Node..."
export PATH="$NVM_DIR/versions/node/v20.18.0/bin:$PATH"

# Ensure ownership
echo "👤 Setting correct ownership for project directory..."
sudo chown -R ubuntu:ubuntu /home/ubuntu/ProdGameServerBE

# Set project path
echo "📁 Navigating to project directory..."
cd /home/ubuntu/ProdGameServerBE || { echo "❌ Failed to change directory"; exit 1; }

# Get branch name
echo "🌿 Checking current Git branch..."
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "🔍 Current branch: $BRANCH_NAME"

if [ "$BRANCH_NAME" = "main" ]; then
    echo "✅ Branch is 'main'. Downloading production environment file..."
    aws s3 cp s3://ludo-lush-env/game-be-lush-ludo-prod-env .env
else
    echo "⚠️ Branch is not 'main'. Deployment aborted."
    exit 1
fi

# Install dependencies
echo "📦 Installing npm dependencies..."
npm i

# Start or reload PM2 app
echo "🚀 Reloading PM2 process: game-be-prod..."
pm2 reload game-be-prod

echo "✅ Deployment script completed successfully."