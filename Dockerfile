# DOCKER-VERSION 1.10.3
FROM        perl:latest
MAINTAINER  Olli-Antti Kivilahti kivilahtio@gmail.com

#Install dependency managers
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton
RUN apt-get update && apt-get install -y npm && npm install -g npm #Upgrade npm to newest version

#Deploy source code
COPY . /usr/src/ceeveelicious
WORKDIR /usr/src/ceeveelicious
RUN export PERL5LIB="/usr/src/ceeveelicious/cee_vee_licious/lib:$PERL5LIB"

#Install dependencies
RUN carton install
RUN ln -s /usr/bin/nodejs /usr/bin/node #Fix a Debian bug
RUN npm install -g less

#Install database
RUN carton exec cee_vee_licious/script/installer.pl

#Expose ports
EXPOSE 3000 #Mojolicious daemon

#Execute app
CMD carton exec cee_vee_licious/script/cee_vee_licious daemon
