# DOCKER-VERSION 1.10.3
FROM        perl:latest
MAINTAINER  Olli-Antti Kivilahti kivilahtio@gmail.com

#Install dependency managers
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton
RUN apt-get install npm

#Deploy source code
COPY . /usr/src/ceeveelicious
WORKDIR /usr/src/ceeveelicious

#Install dependencies
RUN carton install --deployment
RUN npm install -g less && ln -s /usr/bin/nodejs /usr/bin/node #Fix a Debian bug

#Expose ports
EXPOSE 80

#Execute app
CMD carton exec cee_vee_licious/script/cee_vee_licious
