FROM mhart/alpine-node

WORKDIR /source
CMD nginx -c /nginx.conf

RUN apk add --no-cache nginx curl
ADD nginx.conf /

RUN curl https://github.com/gohugoio/hugo/releases/download/v0.42.1/hugo_0.42.1_Linux-64bit.tar.gz -L -s -o /tmp/hugo.tar.gz
RUN tar -zxvf /tmp/hugo.tar.gz -C /tmp
RUN rm /tmp/hugo.tar.gz

ONBUILD ADD . ./
ONBUILD RUN /tmp/hugo -s /source -d /app
