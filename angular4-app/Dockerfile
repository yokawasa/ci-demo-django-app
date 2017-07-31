FROM node:8.1.2
MAINTAINER Yoichi Kawasaki

### based on App Services Default Node 8.1.2 Built-in Container
# https://github.com/Azure-App-Service/node/tree/master/8.1.2

COPY webapp /opt/webapp
COPY sshd_config /etc/ssh/
COPY init_container.sh /bin/

RUN mkdir -p /home/LogFiles \
     && echo "root:Docker!" | chpasswd \
     && apt update \
     && apt install -y --no-install-recommends openssh-server vim

# Workaround for https://github.com/npm/npm/issues/16892
# Running npm install as root blows up in a  --userns-remap
# environment.

RUN chmod -R 777 /opt/webapp \
    && chmod 777 /bin/init_container.sh

USER node

RUN cd /opt/webapp \
  && npm install

USER root

# End workaround

EXPOSE 2222 4200

ENV PORT 4200
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
# ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /opt/webapp

ENTRYPOINT ["/bin/init_container.sh"]
