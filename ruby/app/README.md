[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop) <a href="https://github.com/luciandavila/hiring/actions?query=workflow%3Aci"><img alt="ci status" src="https://github.com/luciandavila/hiring/workflows/ci/badge.svg"></a>

# Alive App Tecnical Test

This project has been developed in order to attend the ruby tecnical test from Alive App. The implementation uses Ruby on Rails. 

In short, the project consists of a smartphones inventory of a virtual store that can be updated through the upload of csv files and also can be filtered through the interface.

## Technical highlights of the solution

* Continuous integration runs the test suite and the rubocop linter (you can access workflows either by clicking on the ci badge or the actions tab);

* Test suite uses good tools (rspec, shoulda matchers, factory bot, database cleaner, etc.);

* Filterable columns from the SQL smartphones table have been indexed, which makes filtering faster;

* Inventory updates are done asynchronously, which makes the application more scalable and allows the processing of larger files;

* Each inventory update is protected in an ActiveRecord transaction, so if any error occurs during the process, the smartphones table is not changed;

* If the processing of an update suffers an unexpected error, the user can decide to retry it through the interface.

## Setup

After cloning this repo, before running the app, you need to:
```bash

# navigate to the correct folder
$ cd ruby/app

# use the expected ruby ​​version (2.6.6) (you can install the version  manually if you want to)
$ rvm use

# install the dependencies
$ yarn install
$ bundle install

# setup the database
$ bundle exec rake db:setup
```

## Launching the application

``` bash
# run the app at localhost:3000
$ bundle exec rails s
```

## Running automated tests and linter

``` bash
# running the test suite
$ bundle exec rspec

# running the linter
$ bundle exec rubocop
```

## Conclusion

I ended up not having the time I wanted to develop this test, but I would like to list here some improvements that I would have made if there was more time available:

* Upload from the front-end to the cloud: I would upload directly from the front end to a cloud storage tool (Amazon S3 or Google Cloud Storage), which would make the project faster and more scalable.

* Lists pagination: I would have implemented the pagination in smartphone's and inventory updates' lists, to avoid loading too much data at once from the database;

* Design improvements: Although I wrote very basic css, I would like to use some style framework, such as Semantic UI;

* Better test coverage: Increase tests coverage to better cover GET endpoints and their views;

* WebSockets: I would have used action cable to update the processing status of an inventory update, displaying a message with option to see the Inventory right after the processing has finished;

Furthermore, if this project were to run in production, I would use Rollbar, which is a real-time exception reporting service for Ruby and other languages, it helps to monitor and understand errors occurring in production environment in real time, which enables the development team to rapidly fix errors.
