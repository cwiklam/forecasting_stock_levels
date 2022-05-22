FROM ruby:3.1.2

RUN apt-get update -qq && apt-get -y install nodejs postgresql
RUN apt purge cmdtest
RUN apt remove yarn
RUN apt install npm -y
RUN npm install esbuild-linux-64 -g
RUN npm install -g yarn

# navigate to app directory
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN yarn install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD [ "./bin/dev" ]