FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y \
        curl \
    && curl -k -sL https://deb.nodesource.com/setup_20.x | bash - \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y nodejs \
    && npm install -g yarn

WORKDIR /app

# install Actual
RUN curl -LO https://github.com/actualbudget/actual/archive/refs/tags/v24.2.0.tar.gz \
    && tar -xzvf v24.2.0.tar.gz --strip-components=1 \
    && rm -rf v24.2.0.tar.gz \
    && yarn install

EXPOSE 5006

CMD ["yarn", "start"]
