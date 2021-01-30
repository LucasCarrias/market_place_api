FROM ruby:2.7.0

RUN apt-get update && apt-get install -y \
  postgresql-client \
  tzdata \
  nodejs \
  imagemagick \
  git \
  && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
ENV RAILS_ENV development
ENV RACK_ENV development
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_MAX_THREADS 5
ENV WEB_CONCURRENCY 2
ENV DB_REAPING_FREQUENCY 10
ENV WORKER_TIMEOUT 3600

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler -v '2.1.4'
RUN bundle config --global frozen 1
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

RUN mkdir -p tmp/pids

ENV PORT 3000
EXPOSE $PORT
