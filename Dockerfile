FROM ruby:3.1.3

RUN apt-get update && apt-get install -y build-essential

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install unf_ext -v '0.0.7.5'
RUN gem install jira-ruby
RUN gem install rest-client
RUN gem install bundler -v 1.11.2 
RUN bundle install

COPY . .

RUN chmod +x ./migrate_zephyr_to_xray_cloud.rb

CMD ["./migrate_zephyr_to_xray_cloud.rb"]
