FROM alpine:3.10

RUN apk add --no-cache git rsync

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]