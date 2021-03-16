[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop) <a href="https://github.com/luciandavila/smartphones-inventory/actions?query=workflow%3Aci"><img alt="ci status" src="https://github.com/luciandavila/smartphones-inventory/workflows/ci/badge.svg"></a>

# Smartphones Inventory 

This project has been developed in order to attend a technical test. The implementation uses Ruby on Rails. 

In short, the project consists of a smartphones inventory of a virtual store that can be updated through the upload of csv files and also can be filtered through the interface.

You can find an example of a valid uploadable csv file at spec/files/input_valid.csv

## Technical highlights of the solution

* Continuous integration runs the test suite and the rubocop linter (you can access workflows either by clicking on the ci badge or the actions tab);

* Test suite uses good tools (rspec, shoulda matchers, factory bot, database cleaner, capybara, etc.);

* Filterable columns from the SQL smartphones table have been indexed, which makes filtering faster;

* Inventory updates are done asynchronously, which makes the application more scalable and allows the processing of larger files;

* Each inventory update is protected in an ActiveRecord transaction, so if any error occurs during the process, the smartphones table is not changed;

* If the processing of an update suffers an unexpected error, the user can decide to retry it through the interface.

## Setup

After cloning this repo, before running the app, you need to:
```bash
# use the expected ruby ​​version (2.6.6)
# you can install the version manually if you want to, but the project supports ruby version manager:
$ rvm use

# install the yarn dependencies
# (recommended node version is 10.20.1; recommended yarn version is 1.22.0)
$ yarn install

# install the ruby dependencies
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

## Further improvements

Here are some improvements that can be made, ordered by priority:

* Upload from the front-end to the cloud: I would upload directly from the front end to a cloud storage tool (Amazon S3 or Google Cloud Storage), which would make the project faster and more scalable ([ActiveStorage supports this](https://github.com/rails/rails/tree/master/activestorage#direct-uploads) through its Javascript library).

* Lists pagination: I would have implemented the pagination in smartphone's and inventory updates' lists, to avoid loading too much data at once from the database;

* Design improvements: Although I wrote very basic css, I would like to use some style framework, such as Semantic UI;

* WebSockets: I would have used action cable to update the processing status of an inventory update, displaying a message with option to see the Inventory right after the processing has finished;

Furthermore, if this project were to run in production, I would use Rollbar, which is a real-time exception reporting service for Ruby and other languages, it helps to monitor and understand errors occurring in production environment in real time, which enables the development team to rapidly fix errors.
