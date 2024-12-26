FROM ruby:3.4.1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl https://deb.nodesource.com/setup_14.x | bash
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /app
WORKDIR /app
COPY ./apps/rails-demo/Gemfile ./apps/rails-demo/Gemfile.lock ./
RUN gem install bundler:2.2.25 \
 && bundle install
COPY ./apps/rails-demo/. .

RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
