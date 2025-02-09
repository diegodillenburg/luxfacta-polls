FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils

ARG INSTALL_PATH
ARG RAILS_PORT

WORKDIR $INSTALL_PATH

RUN mkdir log

COPY public public/

COPY docker/web/nginx.conf /tmp/docker.nginx

RUN envsubst '$INSTALL_PATH' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
