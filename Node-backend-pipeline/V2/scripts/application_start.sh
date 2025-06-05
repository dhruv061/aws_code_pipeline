#!/bin/bash

echo "🛠️ Starting Admin Server deployment..."

# Load NVM and set node version
echo "📦 Loading NVM..."
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "🔧 Switching to Node.js v20.18.0..."
nvm use v20.18.0

# Add node binaries to PATH explicitly
echo "🛠️ Updating PATH for Node.js..."
export PATH="$NVM_DIR/versions/node/v20.18.0/bin:$PATH"

# Ensure ownership
echo "👤 Setting correct ownership for project directory..."
sudo chown -R ubuntu:ubuntu /home/ubuntu/ProdAdminServerBE

# Set project path
echo "📁 Navigating to project directory..."
cd /home/ubuntu/ProdAdminServerBE || { echo "❌ Failed to change directory"; exit 1; }

# Get current Git branch
echo "🌿 Checking current Git branch..."
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "🔍 Current branch: $BRANCH_NAME"

# Download environment file if on main branch
if [ "$BRANCH_NAME" = "Stag_Branch" ]; then
    echo "✅ Branch is 'Stag_Branch'. Downloading production .env file..."
    aws s3 cp s3://ludo-lush-env/stag-env/admin-be-lush-ludo-stag-env .env
elif [ "$BRANCH_NAME" = "main" ]; then
    echo "✅ Deploying Production environment..."
    aws s3 cp s3://ludo-lush-env/prod-env/admin-be-lush-ludo-prod-env .env
    npm i
else
    echo "⚠️ Branch is not 'Stag_Branch' or "main". Deployment aborted."
    exit 1
fi

# Install dependencies
echo "📦 Installing npm dependencies..."
npm i

# Reload PM2 app
if [ "$BRANCH_NAME" = "Stag_Branch" ]; then
    echo "🚀 Reloading PM2 process: admin-be-stag..."
    pm2 reload admin-be-stag
elif [ "$BRANCH_NAME" = "main" ]; then
    echo "🚀 Reloading PM2 process: admin-be-prod..."
    pm2 reload admin-be-prod
else
    echo "⚠️ Branch is not 'Stag_Branch' or "main". Deployment aborted."
    exit 1
fi

echo "✅ Admin Server deployment completed successfully."
