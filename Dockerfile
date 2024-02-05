FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    apache2 \
    lsb-release \
    build-essential

#ENV NVM_VERSION v0.39.7
#ENV NODE_VERSION v12.0.0
#ENV NVM_DIR /root/.nvm
#RUN mkdir $NVM_DIR
#RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

#ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
#ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

#RUN echo "source $NVM_DIR/nvm.sh && \
#    nvm install $NODE_VERSION && \
#    nvm alias default $NODE_VERSION && \
#    nvm use default" | bash

#RUN wget -qO- https://download.rethinkdb.com/repository/raw/pubkey.gpg | \
#    sudo gpg --dearmor -o /usr/share/keyrings/rethinkdb-archive-keyrings.gpg

#RUN echo "deb [signed-by=/usr/share/keyrings/rethinkdb-archive-keyrings.gpg] https://download.rethinkdb.com/repository/ubuntu-$(lsb_release -cs) $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list

#RUN apt-get update && apt-get install -y rethinkdb

# Create directories for the Git repos
RUN mkdir -p /app/client /app/server

# Clone the Git repos into their respective directories
WORKDIR /app/client
RUN git clone https://github.com/Guess-The-Song/client.git .
RUN cp -r /app/client/.output/public/* /var/www/html/
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


WORKDIR /app
RUN rm -rf /app/client

#WORKDIR /app/server
#RUN git clone https://github.com/Guess-The-Song/server.git .
