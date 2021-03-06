# Multipage-frontend

**Travel advice is now rendered by [government-frontend](https://github.com/alphagov/government-frontend). This application is being retired.**

## Screenshots

![Travel Advice](https://raw.githubusercontent.com/alphagov/multipage-frontend/master/docs/assets/screenshot.png)

## Live Examples

- [gov.uk/foreign-travel-advice/albania](https://www.gov.uk/foreign-travel-advice/albania)

## Technical documentation

This is a Ruby on Rails application that renders content items from the  [content-store](https://github.com/alphagov/content-store) which have multiple parts or pages.

### Dependencies

- [alphagov/content-store](https://github.com/alphagov/content-store) - provides content items as JSON
- [alphagov/slimmer](https://github.com/alphagov/slimmer) - provides common frontend componentry
- [alphagov/static](https://github.com/alphagov/static) - provides common assets

### Running the application

`./startup.sh`

### Running the test suite

`bundle exec rake`

## Licence

[MIT License](LICENCE)
