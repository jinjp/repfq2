FROM alpine:latest

ADD configure.sh /configure.sh

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && chmod +x /configure.sh

ENTRYPOINT ["sh", "-c", "/configure.sh"]
