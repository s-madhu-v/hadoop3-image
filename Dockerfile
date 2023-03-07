FROM alpine:latest

RUN apk update && apk add --no-cache python3

CMD ["python3"]