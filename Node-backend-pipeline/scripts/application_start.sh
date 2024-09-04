#!/bin/bash
cd /home/ubuntu/Avantika-Ludo-Admin-Backend
# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Conditionally reload the application using pm2 based on branch name
if [ "$BRANCH_NAME" = "prod" ]; then
    #pm2 reload ludo-fever-admin-backend-prod 
elif [ "$BRANCH_NAME" = "stag" ]; then
    pm2 reload ludo-gin-admin-backend-stag
else
    echo "Branch does not match 'prod' or 'stag'. Please ensure you are on the correct branch."
    exit 1
fi