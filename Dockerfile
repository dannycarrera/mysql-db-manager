FROM mysql:5.7

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]