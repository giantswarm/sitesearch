FROM jeanblanchard/busybox-java:8

MAINTAINER Marian Steinbach

ENV ES_VERSION 1.5.2

# Install ElasticSearch
RUN cd / \
  && curl -O --insecure https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz \
  && gunzip elasticsearch-$ES_VERSION.tar.gz \
  && tar xf elasticsearch-$ES_VERSION.tar \
  && rm elasticsearch-$ES_VERSION.tar \
  && mv elasticsearch-$ES_VERSION elasticsearch

# Define mountable directories.
VOLUME ["/data"]

VOLUME ["/logs"]

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

