FROM alpine:3.4

EXPOSE 5000
WORKDIR /app
CMD nginx -c /nginx.conf

RUN apk add --no-cache nginx
ADD nginx.conf /

ONBUILD ADD . ./
RUN apt-get update
RUN apt-get install -y curl
RUN mv /app /source
RUN curl https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1_Linux-64bit.tar.gz -L -s -o /tmp/hugo.tar.gz
RUN tar -zxvf /tmp/hugo.tar.gz -C /tmp
RUN cd /source && /tmp/hugo -d /app
