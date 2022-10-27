# Stage 1: build the app

FROM registry.access.redhat.com/ubi8/nodejs-16 AS builder
WORKDIR /opt/app-root/src
COPY package.json /opt/app-root/src
USER root
RUN yum update -y 
RUN npm -v 
# && npm install -g

# COPY . /opt/app-root/src

USER 1001
EXPOSE 8080

CMD ["/bin/bash",  "-c",  "echo 'good morning!'"]

