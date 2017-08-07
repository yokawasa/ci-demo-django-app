FROM ubuntu:16.04
MAINTAINER Dockerfiles

### This is based on Dokerfile for Django, uWSGI and Nginx in a container, using Supervisord
###  https://github.com/dockerfiles/django-uwsgi-nginx

# Install required packages and remove the apt packages cache when done.
RUN apt-get update && \
    apt-get upgrade -y && \ 	
    apt-get install -y \
	git \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	nginx \
	supervisor \
	sqlite3 \
	openssh-server vim curl && \
	pip3 install -U pip setuptools && \
    rm -rf /var/lib/apt/lists/*

# install uwsgi now because it takes a little while
RUN pip3 install uwsgi

# setup all the configfiles
COPY sshd_config /etc/ssh/
COPY init_container.sh /bin/
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/


RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
     && mkdir -p /home/LogFiles \
     && echo "root:Docker!" | chpasswd \
     && mkdir -p /usr/src/django/app \
     && chmod 777 /bin/init_container.sh

COPY uwsgi.ini /usr/src/django/
COPY uwsgi_params /usr/src/django/

# COPY requirements.txt and RUN pip install BEFORE adding the rest of your code, this will cause Docker's caching mechanism
# to prevent re-installing (all your) dependencies when you made a change a line or two in your app.
COPY webapp/requirements.txt /usr/src/django/app
RUN pip3 install -r /usr/src/django/app/requirements.txt

# add (the rest of) our code
COPY webapp /usr/src/django/app

EXPOSE 8080 2222
ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance

WORKDIR /usr/src/django/app

ENTRYPOINT ["/bin/init_container.sh"]
