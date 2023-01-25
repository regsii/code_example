# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



# Development

## Setup

Check if Docker is installed
```
docker --version
```

Run the app:
```
docker compose up
```

Wait until database is ready...
```
# rails_example-db-1   | 2023-01-25 15:55:34.727 UTC [1] LOG:  database system is ready to accept connections
```

in a new terminal tab create database (if not created)...
```
docker compose run web rake db:create
```

... migrate database:
```
docker compose run web rake db:migrate
```

Open the app at
```
http://localhost:3000
```

## Rebuild

After some configuration changes rebuild is required:
```
docker compose up --build
# or
docker compose run web bundle install
docker compose up --build
```
