FROM openjdk:11-jre-slim

ARG kafka_version=2.8.2
ARG scala_version=2.13

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY kafka-downloader.sh start-kafka.sh /tmp/

RUN set -eux \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
      jq \
      net-tools \
      curl \
      wget \
    && chmod a+x /tmp/*.sh \
    && mv /tmp/start-kafka.sh /usr/bin \
    && /tmp/kafka-downloader.sh \
    && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
    && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
    && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

CMD ["start-kafka.sh"]
