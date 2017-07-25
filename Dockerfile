FROM alpine:3.5

EXPOSE 5000
WORKDIR /source
CMD nginx -c /nginx.conf

RUN apk add --no-cache nginx curl
ADD nginx.conf /

RUN curl https://github.com/gohugoio/hugo/releases/download/v0.25.1/hugo_0.25.1_Linux-64bit.tar.gz -L -s -o /tmp/hugo.tar.gz
RUN tar -zxvf /tmp/hugo.tar.gz -C /tmp
RUN rm /tmp/hugo.tar.gz

ONBUILD ADD . ./
ONBUILD RUN /tmp/hugo -s /source -d /app
ONBUILD RUN rm -rf /source
