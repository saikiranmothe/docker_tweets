FROM ubuntu:14.04
MAINTAINER saikiran mothe "saikiran.mothe@gmail.com"

RUN apt-get update
RUN apt-get install -y git-core
RUN apt-get install -y curl
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN git clone https://github.com/saikiranmothe/docker_tweets /opt/docker_tweets/
RUN gem install bundler
RUN gem install --no-rdoc --no-ri sinatra json redis
EXPOSE 5000
RUN cd /opt/docker_tweets && git pull && bundle install
RUN cd /opt/docker_tweets && git pull && bundle install
CMD ["/usr/local/bin/foreman","start","-d","/opt/docker_tweets"]


