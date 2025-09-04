FROM ruby:3.3-alpine AS base

RUN apk add --no-cache \
      build-base \
      yaml-dev \
      bash \
      vips \
      vips-dev \
      nodejs \
      npm \
      git \
      curl \
      gnupg \
  && npm install --global yarn

WORKDIR /srv/jekyll

COPY Gemfile ./

RUN gem install bundler -v 2.6.8 \
  && bundle lock --add-platform x86_64-linux-musl \
  && bundle config set deployment 'true' \
  && bundle config set without 'development test' \
  && bundle install --jobs 4 --retry 5

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]

