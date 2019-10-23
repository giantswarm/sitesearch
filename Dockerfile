# jeanblanchard/java is a small Java image based on alpine
FROM jeanblanchard/java:jre-8

ENV ES_VERSION 1.5.2

# Install ElasticSearch
RUN cd / \
  && apk add --update curl ca-certificates \
  && curl -sS -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz \
  && gunzip elasticsearch-$ES_VERSION.tar.gz \
  && tar xf elasticsearch-$ES_VERSION.tar \
  && rm elasticsearch-$ES_VERSION.tar \
  && mv elasticsearch-$ES_VERSION elasticsearch \
  && apk del curl ca-certificates \
  && rm -rf /var/cache/apk/*

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch", "-Des.logger.level=INFO"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
