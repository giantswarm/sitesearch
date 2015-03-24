FROM java:8

MAINTAINER Marian Steinbach

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget --quiet https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz && \
  tar xvzf elasticsearch-1.3.4.tar.gz && \
  rm -f elasticsearch-1.3.4.tar.gz && \
  mv /tmp/elasticsearch-1.3.4 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

VOLUME ["/logs"]

# Define working directory.
WORKDIR /data

# Set timezone to UTC and sync time
RUN echo "UTC" | tee /etc/timezone
RUN ntpdate -s ntp.ubuntu.com

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define default command.
#CMD ["/elasticsearch/bin/elasticsearch", "-Des.logger.level=DEBUG"]
CMD ["/elasticsearch/bin/elasticsearch", "-Des.logger.level=INFO"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

