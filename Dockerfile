FROM ruby:2.3
MAINTAINER Sawood Alam <https://github.com/ibnesayeed>

ENV LANG C.UTF-8

RUN apt update && apt install -y libgsl0-dev && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget http://download.redis.io/redis-stable.tar.gz \
    && tar xvzf redis-stable.tar.gz \
    && cd redis-stable \
    && make && make install \
    && cd /tmp && rm -rf redis-stable*

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN bundle install
RUN gem install narray nmatrix gsl redis

CMD redis-server --daemonize yes && rake
