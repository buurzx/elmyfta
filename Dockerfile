FROM ruby:2.4.1

ENV DIR=/myfta \
    BUNDLE_JOBS=4

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs openssl yarn

RUN mkdir $DIR
WORKDIR $DIR

ADD Gemfile $DIR/Gemfile
ADD Gemfile.lock $DIR/Gemfile.lock

RUN bundle install
RUN gem install foreman

ADD . $DIR
