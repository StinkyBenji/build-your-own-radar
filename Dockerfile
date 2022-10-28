FROM registry.access.redhat.com/ubi8/nodejs-16 AS build

WORKDIR /src/build-your-own-radar
COPY package.json /src/build-your-own-radar
RUN npm install

COPY --chown=1001 . /src/build-your-own-radar
USER 1001
RUN npm run build:prod

FROM registry.access.redhat.com/ubi8/nginx-120 
USER root
RUN mkdir -p /opt/build-your-own-radar/files

WORKDIR /opt/build-your-own-radar
COPY --from=build /src/build-your-own-radar/dist/* .
COPY --from=build /src/build-your-own-radar/spec/end_to_end_tests/resources/localfiles/* ./files/
COPY --from=build /src/build-your-own-radar/default.template /etc/nginx/conf.d/default.conf

CMD nginx -g "daemon off;"
