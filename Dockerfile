FROM ruby:2.6.1

ARG INSTALL_PATH
ARG RAILS_PORT

ENV TZ=America/Sao_Paulo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --pre
RUN bundle install
COPY . .
VOLUME ["$INSTALL_PATH/public"]
EXPOSE $RAILS_PORT
