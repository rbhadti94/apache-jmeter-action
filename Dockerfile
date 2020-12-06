FROM alpine:3.12.1

LABEL "maintainer" "Ravindra Bhadti"

LABEL "com.github.actions.name"="apache-jmeter"
LABEL "com.github.actions.description"="Run Apache JMeter Performance Tests"

ENV JMETER_VERSION "5.4"
ENV JMETER_HOME "/opt/apache/apache-jmeter-${JMETER_VERSION}"
ENV JMETER_BIN "${JMETER_HOME}/bin"
ENV PATH "$PATH:$JMETER_BIN"

COPY entrypoint.sh /entrypoint.sh

RUN apk --no-cache add curl ca-certificates openjdk9-jre && \
    curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -zxvf /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/apache && \
    mv apache-jmeter-${JMETER_VERSION} /opt/apache && \
    rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    rm -rf /var/cache/apk/* && \
    chmod a+x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]