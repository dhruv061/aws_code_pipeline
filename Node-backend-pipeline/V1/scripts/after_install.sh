#!/bin/bash

sudo chown -R ubuntu:ubuntu /home/ubuntu/Avantika-Ludo-Admin-Backend

# Navigate to the application directory
cd /home/ubuntu/Avantika-Ludo-Admin-Backend

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Conditionally copy the correct environment file from S3 based on branch name
if [ "$BRANCH_NAME" = "prod" ]; then
    # echo "Branch is production. Copying prod environment file..."
    # aws s3 cp s3://ludo-fever-env/prod/ludo-fever-admin-prod-env .env
elif [ "$BRANCH_NAME" = "stag" ]; then
    echo "Branch is staging. Copying stag environment file..."
    aws s3 cp s3://ludo-gin-env/stag/ludo-gin-admin-backend-stag-env .env
else
    echo "Branch does not match 'prod' or 'stag'. Please ensure you are on the correct branch."
    exit 1
fi

# Install dependencies
npm i