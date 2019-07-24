# TK-Bank-API

## Contributing

To contribute with this project please refer to [Contribution Guidelines](https://github.com/erickm93/tk-bank-api/blob/master/CONTRIBUTING.md).

## Introduction

An API that handles money transfers between user accounts.

### Features

- Authentication enpoint that returns a [JWT (JSON Web Token)](https://jwt.io/).
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
This is a [Restful](https://restfulapi.net/ "Restful API explanation") API, so it follows it conventions for routes.

### Errors

Error responses will follow this format:
```json
{
  "errors": "[]:string"
}
```

### Currency

The primary currency is BRL (Brazilian real).

### Include options

Using query params it is possible to specify what relationship to include in the response.

Example:
```
curl -X GET \
  http://localhost:3000/accounts/:account_id/?include_user=true \
  -H 'Authorization: Bearer :JWT'
```

### Authentication Endpoint

Authenticate an user using its email.
Returns a JWT.

#### POST /auth/login

```
curl -X POST \
  http://localhost:3000/auth/login \
  -H 'Content-Type: application/json' \
  -d '{
    "user": {
      "email": "example@email.com"
    }
  }'
```

Payload format:
```json
{
  "user": {
    "email": "string"
  }
}
```

Response format:
```json
{
  "token": "string:JWT"
}
```

### Protected Endpoints

All the endpoints listed bellow are protected, so it requires the Authorization header set with a valid JWT.

### Accounts Endpoint

Returns a account.

#### GET /accounts/:account_id

```
curl -X GET \
  http://localhost:3000/accounts/:account_id \
  -H 'Authorization: Bearer :JWT'
```

Response format:
```json
{
  "account": {
    "id": "number",
    "balance_cents": "number",
    "balance": "formated_balance_value:string"
  }
}
```

#### Optional includes

- User

Response format:
```json
{
  "account": {
    "id": "number",
    "balance_cents": "number",
    "balance":"formated_currency_value:string",
    "user": {
      "id": "number",
      "email": "string",
      "first_name": "string",
      "last_name": "string"
    }
  }
}
```

### Transfers Endpoint

Create a Transfer and proccess the funds in destination and source accounts.
Returns the created transfer with the accounts related included.

#### POST /transfers

```
curl -X POST \
  http://localhost:3000/transfers \
  -H 'Authorization: Bearer :JWT' \
  -H 'Content-Type: application/json' \
  -d '{
    "transfer": {
      "value": "10.00",
      "destination_id": "1",
      "source_id": "2"
    }
  }'
```

Payload format:
- Value format: '00.00'
  - where the decimals are separated with dot ('.'). 

```json
{
  "transfer": {
    "value": ":value_format:string",
    "destination_id": "number",
    "source_id": "number"
  }
}
```

Response format:
```json
{
  "transfer": {
    "id": "number",
    "initial_balance_cents": "number",
    "value_cents": "number",
    "initial_balance": "formated_currency_value:string",
    "value": "formated_currency_value:string",
    "destination": {
      "id": "number",
      "balance_cents": "number",
      "balance": "formated_currency_value:string"
    },
    "source": {
      "id": "number",
      "balance_cents": "number",
      "balance": "formated_currency_value:string"
    }
  }
}
```
## Tests

This project uses [Rspec](https://rspec.info/ "Rspec's Homepage") as it's testing tool.

To run the entire test suite, run:

```
cd ./ (to the repository folder)

rspec
```

You should see something like this:

```
CreateTransfer
  .call
    with inexistent destination_id
      does not create the transfer
      fails
      returns inexistent destination account message
    with correct arguments
      debits the source account
      creates the transfer
      sets the correct columns on transfer
      succeeds
      returns the created transfer
      returns no erros
      credits the destination account
    with inexistent destination_id and source_id
      fails
      returns inexistent message for both
      does not create the transfer
    with inexistent source_id
      fails
      returns inexistent source account message
      does not create the transfer
    with incorrect formatted value
      returns incorrect value message
      fails
      does not create the transfer
```

If the text from the output is green :green_heart: means that the test passed and a red :red_circle: text means that it failed.

## License

Licensed under the MIT license, see the separate LICENSE file.
