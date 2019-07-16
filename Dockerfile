# We currently use Ruby 1.9.3 in prod, but bundle install is failing with that in dev.
# We also can't use the newest ruby because it broke support for the syck gem in v2.2.
FROM ruby:2.1

#fix for jessie repo eol issues
RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update -qq && apt-get install -y build-essential libpq-dev gettext

# The rubycas Gemfile / gemspec doesn't specify a rails version since we use Apache Passenger modrails to run it in prod.  
# Need this installed in the container to run the dev version.
#RUN gem install rails -v 3.2

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD rubycas-server.gemspec /app/rubycas-server.gemspec
RUN bundle install

# Do this after bundle install b/c if we do it before then changing any files
# causes bundle install to be invalidated and run again on the next build 
ADD . /app


