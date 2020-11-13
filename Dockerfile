FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN bundle config set path 'vendor/bundle'
RUN mkdir /sample
WORKDIR /
ADD ./sample/Gemfile Gemfile
ADD ./sample/Gemfile.lock Gemfile.lock
RUN bundle install
WORKDIR /sample
COPY ./sample /sample
