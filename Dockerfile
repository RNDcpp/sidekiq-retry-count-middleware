FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /sample
WORKDIR /sample
COPY ./sample /sample
