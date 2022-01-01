# GraphQLClient

This package contains a simple implementation of a network layer to connect to a GraphQL API, powered by [Apollo](https://www.apollographql.com).

------

## Installation

Include the package as a you would with any other local SPM dependency.

------

## Usage

The main object of this package is [GraphQLClient](./Sources/GraphQLClient/GraphQLClient.swift). 

`GraphQLClient` exposes a single function to execute a `GraphQLQuery` and return the result, either success or failure, on the MainThread through the passes `completionHandler` closure.

### Cache

In the current implementation, the client will attempt to setup a SQLite DB to persist the from every request.

The client is also configured to always returned the cached data if available.

Use the correct `CachePolicy` to clear the cache when needed.

------

 ## Dependencies

This package is powered by Apollo to ease the execution of the requests to the GraphQL server.

------

## Tests

This package contains a basic suit of tests for `GraphQLClient` and `CachePolice`

