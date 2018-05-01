FROM node:9.4.0-alpine
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

COPY startup /opt/startup
COPY app.js /home/site/wwwroot/app.js
COPY hostingstart.html /home/site/wwwroot/hostingstart.html
COPY sshd_config /etc/ssh/

RUN echo "ipv6" >> /etc/modules

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories;

RUN npm install -g pm2 \
     && mkdir -p /home/LogFiles \
     && echo "root:Docker!" | chpasswd \
     && echo "cd /home/site/wwwroot" >> /etc/bash.bashrc \
     && apk update --no-cache \
     && apk add openssh \
     && apk add openrc \
     && apk add vim \
     && apk add curl \
     && apk add wget \
     && apk add tcptraceroute \
     && apk add bash \
     && chmod 755 /opt/startup/init_container.sh \
     && cd /home/site/wwwroot \
     && npm install express

EXPOSE 2222 8080

ENV PM2HOME /pm2home

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/opt/startup/init_container.sh"]
