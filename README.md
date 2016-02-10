# Multipage-frontend

A frontend application for rendering content across multiple pages.

## Screenshots

![Travel Advice](https://raw.githubusercontent.com/alphagov/multipage-frontend/master/docs/assets/screenshot.png)

## Live Examples

- [gov.uk/foreign-travel-advice/albania](https://www.gov.uk/foreign-travel-advice/albania)

## Technical documentation

This is a Ruby on Rails application that renders content items from the  [content-store](https://github.com/alphagov/content-store) which have multiple parts or pages.

### Dependencies

- [alphagov/content-store](https://github.com/alphagov/content-store) - provides content items as JSON

### Running the application

`./startup.sh`

Documentation for where the app will appear (default port, vhost, URL etc).

### Running the test suite

`bundle exec rake`

## Licence

[MIT License](LICENCE)
