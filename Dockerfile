FROM alpine:3.6

RUN apk add --no-cache bash

ADD entrypoint.sh /
ADD test /test

ENTRYPOINT ["/entrypoint.sh"]
