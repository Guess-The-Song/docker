FROM ubuntu:latest

RUN wget -qO- https://download.rethinkdb.com/repository/raw/pubkey.gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/rethinkdb-archive-keyrings.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/rethinkdb-archive-keyrings.gpg] https://download.rethinkdb.com/repository/ubuntu-$(lsb_release -cs) $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    apache2 \
    rethinkdb

# Create directories for the Git repos
RUN mkdir -p /app/client /app/server

# Clone the Git repos into their respective directories
WORKDIR /app/client
RUN git clone https://github.com/Guess-The-Song/client.git .
RUN npm install && npx nuxi generate
RUN cp -r /app/client/.output/public/* /var/www/html/
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


WORKDIR /app
RUN rm -rf /app/client

#WORKDIR /app/server
#RUN git clone https://github.com/Guess-The-Song/server.git .
