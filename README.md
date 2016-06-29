# Challenge Platform

[![Stories in Ready](https://badge.waffle.io/RedesignChallenge/challenge-platform.svg?label=ready&title=Ready)](http://waffle.io/RedesignChallenge/challenge-platform)
[![CircleCI](https://circleci.com/gh/RedesignChallenge/challenge-platform/tree/master.svg?style=svg)](https://circleci.com/gh/RedesignChallenge/challenge-platform/tree/master)

##Installation Dependencies

This application requires these additional services to be installed beforehand:

 - Sidekiq
 - PostgreSQL with the HStore extension
 - Redis
 - Memcached

## Seeding and Recreating the Database

The application assumes that at least one Challenge is created before running.  This may be changed in a future release, but without that entity, the application will not start.

In order to initialize the database, use `rake db:recreate`.

## Running the Test Suite

```S3_REGION=test bundle exec rspec```

## database.yml configuration

You will require a .yml file to live in config/database.yml.  For local deployment, you only require a `development` and `test` section.  For deployments to production, you will require a `production` section as well.

A sample:

    development:
      adapter: <DB_ADAPTER>
      database: <DB_NAME>
      username: <DB_USERNAME>
      password: <DB_PASSWORD>
      host: <DB_HOST> (locally can be localhost)

    test:
      adapter: <DB_ADAPTER>
      database: <DB_NAME>_test
      username: <DB_USERNAME>
      password: <DB_PASSWORD>
      host: localhost

## .env configuration

You will require a file called `.env` in the root of the project.

    ## Keys which are mandatory and will prevent the application from running

    # Supported values are http and https
    SITE_PROTOCOL

    # Configuration which specifies the address and port of the server you're deploying
    SITE_HOST

    # Which environment to deploy to; supported values are local, staging, and production.
    # For development and the rake db:recreate command,  "local" is required.
    DEPLOY_REMOTE

    ## Keys which are optional

    # Configuration associated with emailing registrants of the platform
    # Required if the intent is to send emails in production; not needed for local development.
    MANDRILL_APIKEY
    MANDRILL_USERNAME

    # Configuration associated with Amazon S3
    # Required if the intent is to allow uploading of avatars.
    S3_BUCKET
    S3_KEY
    S3_SECRET
    S3_REGION

    # Configuration associated with Twitter.
    # Required if the intent is to display tweets inline with content, or to allow the fetching of avatars from Twitter.
    # Note that there exists a fallback for pulling back avatars with Twitter.
    TWITTER_CONSUMER_KEY
    TWITTER_CONSUMER_SECRET
    TWITTER_ACCESS_TOKEN
    TWITTER_ACCESS_SECRET

    # Username under which all emails are sent as from the platform
    # Required if the intent is to send emails in production.
    GMAIL_USERNAME

    # This adds support for Sidekiq to have more threads when connecting to the database.
    # In support of Heroku, if you have DATABASE_URL set, then this option will be used.
    SIDEKIQ_CONCURRENCY

    # Only used to support SIDEKIQ_CONCURRENCY; not necessary in development
    DATABASE_URL

    # Used for production, this is in support of the Dalli cache store used for the site.
    MEMCACHIER_SERVERS
