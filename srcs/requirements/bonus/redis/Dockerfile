FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y redis-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

# to make redis-server start accepting connections from the outside
CMD ["redis-server", "--protected-mode", "no"]
