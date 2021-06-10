FROM ruby:3-slim
LABEL maintainer="pawantlor@gmail.com"
COPY http_server.rb /opt/appruby/http_server.rb
RUN apt-get update && apt-get install -y curl

WORKDIR /opt/appruby/

ENTRYPOINT ["ruby", "http_server.rb"]
