FROM debian:bullseye

# -r system account
# -g group
RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

# install mariadb
RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/setup_db.sh /scripts/
RUN chmod +x /scripts/setup_db.sh

COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/scripts/setup_db.sh"]

# run mysqld in foreground and as mysql user
CMD ["mysqld", "--user=mysql", "--console"]
