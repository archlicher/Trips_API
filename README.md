# Trips API

A RESTful JSON API built with Ruby on Rails that provides trip and destination data.
The API supports searching, filtering, sorting, pagination, and trip creation.

## Tech Stack

* Ruby on Rails (API mode)
* PostgreSQL
* RSpec
* Kaminari (pagination)
* Serializer pattern (Fast JSON API or similar)

---

# Setup & Run Locally

## 1. Clone the repository

```bash
git clone https://github.com/archlicher/Trips_API.git
cd trips_api
```

## 2. Install dependencies

```bash
bundle install
```

## 3. Setup the database

Make sure PostgreSQL is running, then:

```bash
rails db:create
rails db:migrate
rails db:seed
```

This will:

* Create the database
* Run migrations
* Seed the database with 20 trips from `data.json`

## 4. Start the server

```bash
rails server
```

The API will run at:

```
http://localhost:3000
```

Example endpoint:

```
GET http://localhost:3000/api/trips
```

---

# Running the Test Suite

Install test dependencies (if not already installed):

```bash
bundle install
```

Run all tests:

```bash
bundle exec rspec
```

Run a specific test file:

```bash
bundle exec rspec spec/requests/trips_spec.rb
```

The test suite includes:

* Request specs for API endpoints
* Model specs for validations
* Error handling tests
* Filtering, sorting, and pagination tests

---

# API Endpoints

## List Trips

```
GET /api/trips
```

Query parameters:

| Parameter  | Description                             |
| ---------- | --------------------------------------- |
| search     | Search trips by name (case-insensitive) |
| min_rating | Filter trips with rating >= value       |
| sort       | Sort by rating (`asc` or `desc`)        |
| page       | Page number                             |
| per_page   | Results per page (default: 10)          |

Example:

```
/api/trips?search=beach&min_rating=4&sort=desc&page=1
```

---

## Get Trip Details

```
GET /api/trips/:id
```

Returns full trip information.

---

## Create Trip

```
POST /api/trips
```

Request body:

```json
{
  "trip": {
    "name": "Example Trip",
    "image_url": "https://example.com/image.jpg",
    "short_description": "Short description",
    "long_description": "Long description",
    "rating": 5
  }
}
```

Responses:

* `201 Created` – Trip successfully created
* `422 Unprocessable Entity` – Validation errors

---

# Design Decisions

## 1. Use of Scopes for Query Logic

Search, filtering, and sorting are implemented using ActiveRecord scopes.

Benefits:

* Keeps controllers clean
* Improves readability
* Allows easy chaining of queries

Example:

```
Trip.search(params[:search])
    .min_rating(params[:min_rating])
    .sorted(params[:sort])
```

---

## 2. Serializer Pattern

A serializer layer is used instead of rendering models directly.

Reasons:

* Separation of concerns
* Prevents leaking database structure
* Allows different responses for list vs show endpoints

Two serializers were created:

* TripSerializer (index)
* TripDetailSerializer (show)

---

## 3. Pagination

Pagination is implemented using Kaminari.

Benefits:

* Efficient responses
* Prevents returning large datasets
* Provides useful metadata to clients

Response includes:

* current_page
* total_pages
* total_count

---

## 4. Strong Parameters

Rails strong parameters are used to whitelist allowed fields during trip creation.

This improves:

* Security
* Input validation
* API reliability

---

## 5. Database Indexes

Indexes were added on commonly queried fields:

* name
* rating

This improves performance for:

* search queries
* sorting
* filtering

---

# Trade-offs

### Simplicity vs Advanced Search

The search implementation uses a simple SQL `LIKE` query.

Pros:

* Easy to implement
* Works well for small datasets

Cons:

* Not as powerful as full-text search
* For production systems, tools like Elasticsearch or PostgreSQL full-text search might be better.

---

### Basic Caching Not Implemented

Caching could improve performance for the index endpoint but was not added to keep the project simple and focused on core API functionality.

Possible improvement:

* HTTP caching
* Redis caching
* Fragment caching

---

### Authentication Not Included

Authentication and authorization were not included because they were outside the project scope.

In a real production system, this API would likely include:

* JWT authentication
* Rate limiting
* Role-based access control

---

# Future Improvements

If more time were available, the following improvements could be added:

* Docker setup for easier environment setup
* CI pipeline (GitHub Actions)
* API documentation (Swagger / OpenAPI)
* Response caching
* Background jobs for analytics
* Full-text search
* Rate limiting

---

# Author

Hrostofor Todorov
