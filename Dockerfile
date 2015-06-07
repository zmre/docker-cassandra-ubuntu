# This is an adaptation of the official Cassandra Repo, but based on the
# phusion base image (ubuntu) instead of debian.  Here's the original:
# https://github.com/docker-library/cassandra/tree/master/2.1
FROM phusion/baseimage:0.9.16
MAINTAINER IronCore Labs

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 514A2AD631A57A16DD0047EC749D6EEC0353B12C

RUN echo 'deb http://www.apache.org/dist/cassandra/debian 21x main' >> /etc/apt/sources.list.d/cassandra.list

ENV CASSANDRA_VERSION 2.1.5

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get install -y cassandra="$CASSANDRA_VERSION"

ENV CASSANDRA_CONFIG /etc/cassandra

# listen to all rpc
RUN sed -ri ' \
		s/^(rpc_address:).*/\1 0.0.0.0/; \
	' "$CASSANDRA_CONFIG/cassandra.yaml"


RUN mkdir -p /etc/service/cassandra
COPY docker-entrypoint.sh /etc/service/cassandra/run
#ENTRYPOINT ["/docker-entrypoint.sh"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /var/lib/cassandra/data

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160
#CMD ["cassandra", "-f"]
