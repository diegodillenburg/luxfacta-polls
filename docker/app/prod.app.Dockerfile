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

RUN mkdir -p ~/apps/luxfacta-polls
WORKDIR ~/apps/luxfacta-polls
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --pre
RUN bundle config set without 'development test'
RUN bundle install
COPY . .
VOLUME ["~/apps/luxfacta-polls/public"]
EXPOSE $RAILS_PORT
