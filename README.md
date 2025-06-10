# Task
URL Shortener API - Take-home Task
Build a Rails API for a URL shortening service.

Requirements:

1. URL Shortening
- Create an endpoint that accepts a URL and returns a shortened version with an auto-generated unique short code
- Prevent duplicate active URLs - return an error if someone tries to shorten a URL that already exists and is active
- Support batch URL shortening - accept multiple URLs and return multiple shortened URLs in a single request
- Return appropriate JSON responses suitable for frontend consumption

2. URL Management
- Create an endpoint to deactivate a shortened URL
- Once a URL is deactivated, the same original URL can be shortened again (creating a new short code)
- Deactivated URLs should no longer redirect or track clicks

3. Click Tracking
- Create a redirect endpoint that redirects the user to the original URL, and records each click event

4. Analytics
- Create an endpoint that returns shortened URLs with their click statistics
- Accept the following filter parameters:

start_date - beginning of date range
end_date - end of date range
timezone - timezone for the date range filtering, accepting both IANA identifiers (e.g “Europe/Paris”) and ISO 8601 offset (“+5:30”, “-08:00”, “Z”)

- The response should include:
a. The shortened URL details
b. Total click count (all time)
c. Click count within the specified date range (filtered by timezone)


** Technical Guidelines **
- Use PostgreSQL as the database
- Focus on clear, descriptive naming throughout your code
- No test coverage is required
- Implement basic error handling with appropriate HTTP status codes and a consistent error message format
- Follow standard Rails conventions where appropriate
- Design JSON responses that would be easy for a frontend developer to work with


** Testing **
We'll test your API using Postman, so please ensure your endpoints work with standard HTTP requests. You don't need to create a Postman collection or any frontend, but please provide a list of endpoints and JSON payloads or query params to test with.


** Evaluation **

Your submission will be evaluated on:
- Code organization and readability
- Meeting the requirements
- Database design decisions
- How you handle timezone-aware date filtering
- API design and response structure
- Query efficiency for analytics
- General Rails best practices
- Please provide a README with instructions on how to set up and run your application.

------------------------------------------------------------------------------------

# Dependencies
Ruby version >= 3.2.2
PostgreSQL

# Installation Steps:
```
git clone ${repoLink}
cd tiny_url

rvm use 3.2.2
rvm gemset use tiny_url --create
gem install rails --no-document

bundle install
rails db:migrate
```

------------------------------------------------------------------------------------

# Starting the rails server:
```
rails s
```
------------------------------------------------------------------------------------

# Update the api annotation on controllers:
```
bundle exec chusaku
```
------------------------------------------------------------------------------------

# Steps to test endpoints locally:

1. To create a short url
```
curl --location 'http://localhost:3000/api/v1/shorten' \
--header 'Content-Type: application/json' \
--data '{
    "url": "http://www.google.com"
}'
```

2. Batch Short url
```
curl --location 'http://localhost:3000/api/v1/shorten/batch' \
--header 'Content-Type: application/json' \
--data '{
    "urls": ["http://www.youtube.com", "http://www.instagram.com"]
}'
```

3. Deactivate a shortened url
```
curl --location --request POST 'http://localhost:3000/api/v1/deactivate/:code'
eg: curl --location --request POST 'http://localhost:3000/api/v1/deactivate/caKmVQ'
```

4. Access the shortened url
```
curl --location 'http://localhost:3000/:code'
eg: curl --location 'http://localhost:3000/99tS2d'
```

5. Analytics for shortened URLs with their click statistics
```
curl --location 'http://localhost:3000/api/v1/analytics?start_date=9%2F06%2F2025&end_date=10%2F06%2F2025&timezone=Europe%2FParis'
```

------------------------------------------------------------------------------------
