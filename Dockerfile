FROM ruby:2.7

ARG HOST
ARG SSH_KEY

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y install rsync default-mysql-client software-properties-common
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN add-apt-repository 'deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main'
RUN apt update && apt install -y mongodb-org-tools

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN mkdir /root/.ssh
RUN echo "${SSH_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan ${HOST} >> /root/.ssh/known_hosts

RUN mkdir -p /usr/src/app/public/backup

EXPOSE 4567

CMD ["ruby", "./server.rb", "-o", "0.0.0.0"]
