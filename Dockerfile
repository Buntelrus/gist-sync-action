FROM alpine:3.11

RUN apk add --no-cache bash grep curl jq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
