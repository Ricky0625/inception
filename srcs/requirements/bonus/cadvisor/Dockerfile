FROM debian:bullseye

RUN apt-get update && apt-get install wget -y \
    && wget -O cadvisor https://github.com/google/cadvisor/releases/download/v0.46.0/cadvisor-v0.46.0-linux-amd64 \
    && chmod +x cadvisor \
    && rm -rf /var/lib/apt/lists/*

CMD ["./cadvisor"]