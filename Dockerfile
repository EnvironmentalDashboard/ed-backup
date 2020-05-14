FROM ruby:2.7

ARG HOST
ARG SSH_KEY

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN apt-get update && apt-get -y install rsync

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN mkdir /root/.ssh
RUN echo "${SSH_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan ${HOST} >> /root/.ssh/known_hosts

EXPOSE 4567

CMD ["ruby", "./server.rb", "-o", "0.0.0.0"]
