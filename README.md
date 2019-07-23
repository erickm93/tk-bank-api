# TK-Bank-API

## Contributing

To contribute with this project please refer to [Contribution Guidelines](https://github.com/erickm93/tk-bank-api/blob/master/CONTRIBUTING.md).

## Introduction

An API that handles money transfer from between user accounts.

### Features

- Authentication enpoint that returns a JWT.
- Authorization through JWT.
- Transfer endpoint that manages the transfers of funds between two accounts (source and destination).
- Account endpoint that returns a specific account according to the passed id.

## Running locally

This project uses [RVM](https://rvm.io/ "RVM's Homepage") to manage Ruby and Rails/Gems.

You must have [PostgreSQL](https://www.postgresql.org/ "PostgreSQL's Homepage") installed and running.

If you already have RVM installed with its wrappers and bash script it should be straight foward, just run:

```
cd ./ (to the repository folder)

rvm install ruby 2.6.3 (if needed)

gem install bundler -v 2.0.2

bundle install

rails db:create

rails db:migrate

rails db:seed

rails s
```

## Specifications
This is a [Restful](https://restfulapi.net/ "Restful API explanation") API, so it follows it convetions for routes.

### Authentication Endpoint

#### POST /auth/login

```curl
curl -X POST \
  http://localhost:3000/auth/login \
  -H 'Content-Type: application/json' \
  -d '{
	"user": {
		"email": "example@email.com"
	}
}'
```
