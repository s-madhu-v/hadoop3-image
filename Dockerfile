FROM alpine:latest

RUN apk update && apk add --no-cache python3

RUN apk add --update --no-cache openjdk8 build-base autoconf automake libtool protobuf-dev openssl-dev curl git

RUN curl https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz --output hadoop_download.tar.gz

CMD ["python3"]