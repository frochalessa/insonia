FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV RAILS_ROOT /var/www/insonia
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY config/puma.rb config/puma.rb
COPY . .
EXPOSE 3000
CMD ["bundle" "exec" "puma" "-C" "config/puma.rb"]