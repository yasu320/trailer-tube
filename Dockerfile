FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /trailer-tube
WORKDIR /trailer-tube
COPY Gemfile /trailer-tube/Gemfile
COPY Gemfile.lock /trailer-tube/Gemfile.lock
RUN bundle install
COPY . /trailer-tube