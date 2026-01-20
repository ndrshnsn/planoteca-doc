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

# Copy Gemfile first
COPY Gemfile* ./

# Install bundler and add platform
RUN gem install bundler -v 2.6.8 \
    && bundle lock --add-platform x86_64-linux-musl \
    && bundle config set --local deployment 'false' \
    && bundle config set --local path 'vendor/bundle' \
    && bundle install --jobs 4 --retry 5

# Copy the rest
COPY . .

ENV JEKYLL_ENV=production
ENV JEKYLL_URL=https://doc.planoteca.com.br
ENV JEKYLL_BASEURL=

EXPOSE 4000

RUN bundle exec jekyll build \
  --config _config.yml

RUN grep -R "localhost:4000" _site && exit 1 || echo "OK: no localhost"