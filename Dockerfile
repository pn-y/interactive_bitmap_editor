FROM ruby:2.7-alpine

ARG RAILS_ROOT=/app
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
ENV PATH=/app/bin:${PATH}

WORKDIR $RAILS_ROOT

RUN apk update && apk add make bash gcc libc-dev

RUN gem install bundler

COPY Gemfile* ./

RUN bundle config set no-cache 'true' && bundle install --jobs 4 --path=vendor/bundle

COPY . .
