FROM ubuntu:latest

EXPOSE 80
EXPOSE 8080
EXPOSE 3000

#INSTALLS###########################################################

RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    apache2 \
    lsb-release \
    build-essential

#NVM / NPM / NODE SETUP#############################################

ENV NVM_VERSION v0.39.7
ENV NODE_VERSION v16.0.0
ENV NVM_DIR /root/.nvm
RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

RUN echo "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default" | bash

#RETHINKDB INSTALL##################################################

RUN wget -qO- https://download.rethinkdb.com/repository/raw/pubkey.gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/rethinkdb-archive-keyrings.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/rethinkdb-archive-keyrings.gpg] https://download.rethinkdb.com/repository/ubuntu-$(lsb_release -cs) $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list

RUN apt-get update && apt-get install -y rethinkdb

#FRONTEND SETUP#####################################################

RUN mkdir -p /app/client /app/server

WORKDIR /app/client
RUN git clone https://github.com/Guess-The-Song/client.git .
RUN cp -r /app/client/.output/public/* /var/www/html/


WORKDIR /app
RUN rm -rf /app/client

#BACKEND SETUP######################################################

WORKDIR /app/server
RUN git clone https://github.com/Guess-The-Song/server.git .
RUN npm install
RUN mkdir db


#STARTUP SCRIPT#####################################################
COPY start.sh /app/server/start.sh
RUN chmod +x /app/server/start.sh
CMD ["/app/server/start.sh"]