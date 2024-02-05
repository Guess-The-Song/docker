FROM ubuntu:latest

EXPOSE 3000

#INSTALLS###########################################################

RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    lsb-release \
    build-essential

#NVM / NPM / NODE SETUP#############################################

ENV NVM_VERSION v0.39.7
ENV NODE_VERSION v20.11.0
ENV NVM_DIR /root/.nvm
RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

RUN echo "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default" | bash

RUN npm install -g npm@latest

#FRONTEND SETUP#####################################################

RUN mkdir -p /app/client

WORKDIR /app/client
RUN git clone https://github.com/Guess-The-Song/client.git .
RUN rm -rf /app/client/.output
RUN rm -rf /app/client/node_modules
RUN npm i @nuxt/ui
RUN npm ci
RUN npx nuxt build

#STARTUP############################################################
CMD [ "node", "/app/client/.output/server/index.mjs" ]