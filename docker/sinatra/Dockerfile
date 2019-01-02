FROM ruby:2.5.3

CMD mkdir /app
WORKDIR /app/
COPY Gemfile /app/

RUN gem install bundler \
  && bundle install --clean --path vendor/bundle

VOLUME /app/public
VOLUME /app/tmp

COPY . /app/
CMD bundle exec pumactl start
