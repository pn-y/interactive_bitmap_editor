# interactive_bitmap_editor
## README
### Requirements:
docker 19+

docker-compose 1.25+
### Getting started
To build image: `docker-compose build`

To run tests `docker-compose run --rm app bundle exec rake test`

To run script against examples:
1. Go inside container `docker-compose run --rm --it app`
1. Run script with path to example file `bundle exec rake run[test/fixtures/example.txt]` or `ruby bin/runner.rb run test/fixtures/example.txt`
