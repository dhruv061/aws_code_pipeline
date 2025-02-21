# Folder Information!!

## Laravel-Pipeline
AWS Pipeline for Laravel Aplictions.

## Laravel-Socket-Pipeline
AWS Code Pipeline for Socket laravel. 
In Socket pipeline for aws we have same repo as in laravel application. And we have alredy `appspec.yaml` file in repo for laravel appliation pipeline. So we create another file `appspec-socket.yml` and use `buildspec.yaml` to rename this app-spac file from `appspec-socket.yml` to `appspec.yml`. We have to rename `appspec-socket.yml` file beacuse aws codepipeline only read `appspec.yml`.

## Node-backend-pipeline
Node Pipeline

## React-static-frontend-pipeline
React static site pipeline