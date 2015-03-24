FROM java:8

MAINTAINER Marian Steinbach

# Install ElasticSearch
RUN \
  cd /tmp && \
  wget --quiet https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.0.tar.gz && \
  tar xvzf elasticsearch-1.5.0.tar.gz && \
  rm -f elasticsearch-1.5.0.tar.gz && \
  mv /tmp/elasticsearch-1.5.0 /elasticsearch

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

