# Dockerfile development version
#FROM ruby:3.1.2 
#ROM ruby:3.2.0
FROM ruby:3.0.5

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH
COPY / /
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN yarn install

EXPOSE 8080
EXPOSE 3000

# Add a script to be executed every time the container starts.
COPY .dockerdev/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY .dockerdev/migrate.sh /usr/bin/
RUN chmod +x /usr/bin/migrate.sh


CMD bin/rails server -b 0.0.0.0 -p 8080
# Start server
#MD bundle exec unicorn -c config/unicorn.rb
