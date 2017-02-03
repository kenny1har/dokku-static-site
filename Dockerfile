FROM alpine:3.4

EXPOSE 5000
WORKDIR /app
CMD nginx -c /nginx.conf

RUN apk add --no-cache nginx
ADD nginx.conf /

ONBUILD ADD . ./
RUN apk add --update curl
RUN mv /app /source
RUN curl https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1_Linux-64bit.tar.gz -L -s -o /tmp/hugo.tar.gz
RUN tar -zxvf /tmp/hugo.tar.gz -C /tmp
RUN mv /tmp/hugo_0.18.1_linux_amd64/hugo_0.18.1_linux_amd64 /tmp/hugo
RUN cd /source
RUN /tmp/hugo -d /app
