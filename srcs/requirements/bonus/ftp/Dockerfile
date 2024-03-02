FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y vsftpd \
    && mkdir -p /var/run/vsftpd/empty \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/setup_ftp.sh /scripts/
RUN chmod +x /scripts/setup_ftp.sh

COPY ./config/vsftpd.conf /etc/vsftpd.conf

ENTRYPOINT ["/scripts/setup_ftp.sh"]

# run vsftpd in foreground
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]