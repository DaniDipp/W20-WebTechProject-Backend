# Trustmart Backend API
https://github.com/DaniDipp/W20-WebTechProject-Backend

This is the backend application for a Web Technologies project at the Alpen-Adria-University. The frontend has been written by my colleague and can be found [here](koflerm/WebTechProject-Frontend#readme).

## Table of Contents
- [Trustmart Backend API](#trustmart-backend-api)
  - [Table of Contents](#table-of-contents)
  - [Live Demo](#live-demo)
  - [Documentation](#documentation)
    - [Installation](#installation)
      - [Environment Variables](#environment-variables)
    - [Technologies](#technologies)
      - [Node](#node)
      - [Database](#database)
        - [Products](#products)
        - [Categories](#categories)
        - [Users](#users)
        - [Orders](#orders)
        - [Ratings](#ratings)
    - [API Endpoints](#api-endpoints)
      - [Products Endpoint](#products-endpoint)
      - [Categories Endpoint](#categories-endpoint)
      - [Users Endpoint](#users-endpoint)
      - [Orders Endpoint](#orders-endpoint)
      - [Ratings Endpoint](#ratings-endpoint)

## Live Demo
For the duration of the semester, I will be hosting this project on my server at [https://webtech.danidipp.com/](https://webtech.danidipp.com/). 

## Documentation
### Installation
1. Set up the [Database](#database)
2. Install [Node.js](https://nodejs.org/en/)
3. Download the code as ZIP and unpack it or, using the git cli run
```bash
git clone https://github.com/DaniDipp/W20-WebTechProject-Backend.git
```
4. Install the dependencies
```bash
npm install
```
5. Start the server
```bash
npm start
```
#### Environment Variables
| Variable     | Description                                              | Default             |
|--------------|----------------------------------------------------------|---------------------|
| `JWT_SECRET` | The secret JWT will use to [encrypt authentication tokens](https://github.com/auth0/node-jsonwebtoken#jwtsignpayload-secretorprivatekey-options-callback) | `"changeme"`       |
| `DB_HOST`    | IP address or DNS of the database server                 | `"localhost"`       |
| `DB_PORT`    | Database server port number                              | `3306`              |
| `DB_USER`    | User to access database                                  | `"webtech-backend"` |
| `DB_PASS`    | User password                                            | `"changeme"`        |
| `DB_NAME`    | Database to use                                          | `"webtech-backend"` |

### Technologies
#### Node
The server is running [Node.js](https://nodejs.org/en/), using the following dependencies:
- [bcrypt](https://github.com/kelektiv/node.bcrypt.js#readme) to securely hash and compare passwords
- [cors](https://github.com/expressjs/cors#readme) for easily sending CORS headers
- [express](https://expressjs.com) as web application framework
- [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken#readme) to generate and check authentication tokens
- [mariadb](https://github.com/mariadb-corporation/mariadb-connector-nodejs#readme) to communicate with the [database](#database)

#### Database
Because I already had a [MariaDB](https://mariadb.org) database running on my server, I chose that over MySQL or PostgreSQL

You can find the SQL dump of the database with example data [here](webtechproject.sql).

##### Products
| Column        | Type           | Attributes                        |
|---------------|----------------|-----------------------------------|
| id            | `SMALLINT`     | unsigned, primary, auto-increment |
| name          | `VARCHAR(64)`  |                                   |
| price         | `SMALLINT`     | unsigned                          |
| description   | `VARCHAR(256)` | null                              |
| image         | `VARCHAR(64)`  | null                              |
| category_name | `VARCHAR(32)`  | foreign                           |
| last_update   | `TIMESTAMP`    | current timestamp on update       |

##### Categories
| Column        | Type           | Attributes                        |
|---------------|----------------|-----------------------------------|
| name          | `VARCHAR(32)`  | primary                           |
| last_update   | `TIMESTAMP`    | current timestamp on update       |

##### Users
| Column        | Type           | Attributes                        |
|---------------|----------------|-----------------------------------|
| email         | `VARCHAR(32)`  | primary                           |
| password      | `CHAR(60)`     |                                   |
| name          | `VARCHAR(32)`  |                                   |
| address       | `VARCHAR(64)`  | null                              |
| phone         | `VARCHAR(256)` | null                              |
| creditcard    | `VARCHAR(60)`  | null                              |
| last_update   | `TIMESTAMP`    | current timestamp on update       |
- `CHAR(60)` is used to save password hashes, because bcrypt hashes are always exactly 60 characters long.

##### Orders
| Column        | Type           | Attributes                        |
|---------------|----------------|-----------------------------------|
| id            | `SMALLINT`     | unsigned, primary, auto-increment |
| time          | `TIMESTAMP`    |                                   |
| status        | `VARCHAR(24)`  |                                   |
| user_email    | `VARCHAR(32)`  | foreign                           |
| product_id    | `VARCHAR(64)`  | null                              |
| category_name | `SMALLINT`     | unsigned, foreign                 |
| last_update   | `TIMESTAMP`    | current timestamp on update       |

##### Ratings
| Column        | Type           | Attributes                        |
|---------------|----------------|-----------------------------------|
| product_id    | `SMALLINT`     | unsigned, primary, foreign        |
| user_email    | `VARCHAR(32)`  | primary, foreign                  |
| value         | `TINYINT`      | unsigned                          |
| text          | `VARCHAR(128)` | null                              |
| last_update   | `TIMESTAMP`    | current timestamp on update       |

### API Endpoints

#### Products Endpoint
GET `/products`
: Returns all data about all products. (Could be a lot of data)
Authentication: *none*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/products/'
```
```json
{
    "status": "success",
    "message": "Got products from DB",
    "products": [
        {
            "id": 50,
            "name": "Nice Dress",
            "price": 2999,
            "description": "Just a nice Dress.",
            "image": "https://i.imgur.com/DouWP9o.png",
            "category_name": "Apparels",
            "average_rating": 2.5
        },
        ...
    ]
}
```

GET `/products/:id`
: Returns all data about a specific product.
Authentication: *none*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/products/50'
```
```json
{
    "status": "success",
    "message": "Got products from DB",
    "product": {
        "id": 50,
        "name": "Nice Dress",
        "price": 2999,
        "description": "Just a nice Dress.",
        "image": "https://i.imgur.com/DouWP9o.png",
        "category_name": "Apparels",
        "average_rating": 2.5
    }
}
```

GET `/products/search`
: Returns products based on query parameters
Authentication: *none*

Optional Query Parameters:
- `name` case-insensitive, default: *`empty string`*
- `price_min` int, cents, default: `0`
- `price_max` int, cents, default: `65535`
- `description` case-insensitive, default: *`empty string`*
- `category` case-insensitive, comma-separated for union, default: *`empty string`*
Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/products/search?price_max=2000&description=blue'
```
```json
{
    "status": "success",
    "message": "Got products from DB",
    "products": [
        {
            "id": 51,
            "name": "Jeans",
            "price": 899,
            "description": "It's jeans. They're blue.",
            "image": "https://i.imgur.com/STdxvtX.jpg",
            "category_name": "Apparels",
            "average_rating": 2.5
        }
    ]
}
```

#### Categories Endpoint
GET `/categories`
: Returns list of all categories and number of items they include
Authentication: *none*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/categories'
```
```json
{
    "status": "success",
    "message": "Got categories from DB",
    "categories": [
        {
            "name": "Apparels",
            "items": 5
        },
        ...
    ]
}
```

#### Users Endpoint
GET `/users`
: Returns info of user
Authentication: *Bearer token*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/users' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Got user from DB",
    "user": {
        "email": "test@example.com",
        "name": "Test User",
        "address": "Example Street 01, 0000 Example City",
        "phone": null,
        "creditcard": null
    }
}
```

POST `/users`
: Registers a new user and generates token
Token expires after 3 hours
Authentication: *none*

Required Body Parameters:
- name
- email
- password

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/users/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name":"Test User",
    "email":"test@example.com",
    "password": "password123"
}'
```
```json
{
    "status": "success",
    "message": "Added new user to DB",
    "user": {
        "email": "test@example.com",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U",
        "name": "Test User"
    }
}

```

POST `/users/login`
: Logs in an existing user and generates new token
Token expires after 3 hours
Authentication: *none*

Required Body Parameters:
- email
- password

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/users/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email":"test@example.com",
    "password": "password123"
}'
```
```json
{
    "status": "success",
    "message": "Added new user to DB",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U"
}

```

PATCH `/users`
: Updates user info
Authentication: *Bearer token*

Optional body parameters (at least one required):
- password
- name
- address
- phone
- creditcard

Example:
```bash
curl --location --request PATCH 'https://webtech.danidipp.com/users' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U' \
--header 'Content-Type: application/json' \
--data-raw '{
    "address": "Example Street 01, 0000 Example City"
}'
```
```json
{
    "status": "success",
    "message": "Updated user with email test@example.com in DB"
}
```

DELETE `/users`
: Deletes user
Authentication: *Bearer token*

Example:
```bash
curl --location --request DELETE 'https://webtech.danidipp.com/users' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Deleted user with email test@example.com from DB"
}
```

#### Orders Endpoint
GET `/orders`
: Returns list of all orders of user
Authentication: *Bearer token*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/orders' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Got orders for user test@example.com",
    "orders": [
        {
            "id": 7,
            "time": "2021-01-14T02:39:00.000Z",
            "status": "Waiting for Payment",
            "product": {
                "name": "Jeans",
                "price": 899,
                "description": "It's jeans. They're blue.",
                "image": "https://i.imgur.com/STdxvtX.jpg",
                "category": "Apparels",
                "average_rating": 2.5
            }
        },
        ...
    ]
}
```
POST `/orders`
: Creates a new order
Authentication: *Bearer token*

Required body parameters:
- time (parsable by `new Date(time)`[^1])
- status
- product_id

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/orders' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U' \
--header 'Content-Type: application/json' \
--data-raw '{
    "time": "2021-01-14T02:39:00Z",
    "status": "Waiting for Payment",
    "product_id": 51
}'
```
```json
{
    "status": "success",
    "message": "Added new user to DB",
    "order": {
        "id": 7,
        "time": "2021-01-14T02:39:00.000Z",
        "status": "Waiting for Payment",
        "product_id": 51
    }
}
```

DELETE `/orders/:id`
: Deletes a specific order
Authentication: *Bearer token*

Example:
```bash
curl --location --request DELETE 'https://webtech.danidipp.com/orders/7' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Deleted order 7 from DB"
}
```

#### Ratings Endpoint

GET `/ratings`
: Returns all ratings of user
Authentication: *Bearer token*

Example:
```bash
curl --location --request GET 'https://webtech.danidipp.com/ratings' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Got ratings for user test@example.com",
    "ratings": [
        {
            "value": 5,
            "text": "Trousers 👍",
            "product": {
                "id": 51,
                "name": "Jeans",
                "price": "Jeans",
                "description": "It's jeans. They're blue.",
                "image": "https://i.imgur.com/STdxvtX.jpg",
                "category": "Apparels",
                "average_rating": 2.5
            }
        },
        ...
    ]
}
```

POST `/ratings`
: Creates new rating
Authentication: *Bearer token*

Required body parameters:
- product_id
- value

Optional body parameters:
- text

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/ratings' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U' \
--header 'Content-Type: application/json' \
--data-raw '{
    "product_id": "51",
    "value": 5,
    "text": "Trousers 👍"
}'
```
```json
{
    "status": "success",
    "message": "Added new rating to DB",
    "rating": {
        "product_id": 51,
        "user_email": "test@example.com",
        "value": 5,
        "text": "Trousers 👍"
    }
}
```

GET `/ratings/:product_id`
: Returns all ratings of specific product
Authentication: *none*

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/ratings/51'
```
```json
{
    "status": "success",
    "message": "Got ratings for product 51",
    "ratings": [
        {
            "value": 5,
            "text": "Trousers 👍",
            "user": {
                "name": "Test User"
            },
            "product": {
                "id": 51,
                "name": "Jeans",
                "price": "Jeans",
                "description": "It's jeans. They're blue.",
                "image": "https://i.imgur.com/STdxvtX.jpg",
                "category": "Apparels",
                "average_rating": 2.5
            }
        },
        ...
    ]
}
```

PATCH `/ratings/:product_id`
: Updates specific rating
Authorization: *Bearer token*

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/ratings/51' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U' \
--header 'Content-Type: application/json' \
--data-raw '{
    "value": 1,
    "text": "too small for me"
}'
```
```json
{
    "status": "success",
    "message": "Updated rating for product 51 by user test@example.com in DB"
}
```

DELETE `/ratings/:product_id`
: Deletes specific rating
Authentication: *Bearer token*

Example:
```bash
curl --location --request POST 'https://webtech.danidipp.com/ratings/51' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2VtYWlsIjoidGVzdEBleGFtcGxlLmNvbSIsImlhdCI6MTYxMDY0MjgzMywiZXhwIjoxNjEwNjUzNjMzfQ.Ngv2ahZl218S0VDxX-tcfsHbqQClYDqUhrJDhN2-5-U'
```
```json
{
    "status": "success",
    "message": "Removed rating for product 51 by user test@example.com in DB"
}
```







[^1]: [Date() constructor - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/Date)