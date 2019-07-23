FROM elasticsearch:6.4.0

MAINTAINER imriss@yahoo.com

# Override config, otherwise plug-in install will fail
ADD config /elasticsearch/config

# Set environment
ENV DISCOVERY_SERVICE elasticsearch-discovery
ENV STATSD_HOST=statsd.statsd.svc.cluster.local
ENV SEARCHGUARD_SSL_TRANSPORT_ENABLED=true
ENV SEARCHGUARD_SSL_HTTP_ENABLED=true

# Fix bug installing plugins
ENV NODE_NAME=""

# Install search-guard-ssl
RUN ./bin/elasticsearch-plugin install -b com.floragunn:search-guard-6:6.4.0-24.3

# Install s3 repository plugin
RUN ./bin/elasticsearch-plugin install -b repository-s3

# Install gcs repostory plugin
RUN ./bin/elasticsearch-plugin install -b repository-gcs

# Install statsd plugin
RUN ./bin/elasticsearch-plugin install -b https://github.com/Automattic/elasticsearch-statsd-plugin/releases/download/6.4.0.0/elasticsearch-statsd-6.4.0.0.zip

# Install prometheus plugin
RUN ./bin/elasticsearch-plugin install -b https://github.com/vvanholl/elasticsearch-prometheus-exporter/releases/download/6.4.0.0/elasticsearch-prometheus-exporter-6.4.0.0.zip
