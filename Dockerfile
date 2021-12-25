FROM alpine:3.12.1

LABEL "maintainer" "Ravindra Bhadti"
LABEL "com.github.actions.name"="apache-jmeter"
LABEL "com.github.actions.description"="Run Apache JMeter Performance Tests"

ENV JMETER_VERSION "5.4.1"
ENV JMETER_HOME "/opt/apache/apache-jmeter-${JMETER_VERSION}"
ENV JMETER_BIN "${JMETER_HOME}/bin"
ENV PATH "$PATH:$JMETER_BIN"
ENV CMD_RUNNER_VERSION 2.2
ENV JMETER_PLUGIN_VERSION 1.6
ENV MAVEN_REPO "https://repo1.maven.org/maven2/kg/apc"

COPY entrypoint.sh /entrypoint.sh
COPY cleanup.sh /cleanup.sh

RUN apk --no-cache add curl ca-certificates openjdk9-jre parallel bash && \
    curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -zxf /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    mkdir -p /opt/apache && \
    mv apache-jmeter-${JMETER_VERSION} /opt/apache && \
    rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz && \
    curl ${MAVEN_REPO}/cmdrunner/${CMD_RUNNER_VERSION}/cmdrunner-${CMD_RUNNER_VERSION}.jar --output ${JMETER_HOME}/lib/cmdrunner-${CMD_RUNNER_VERSION}.jar && \
    curl ${MAVEN_REPO}/jmeter-plugins-manager/${JMETER_PLUGIN_VERSION}/jmeter-plugins-manager-${JMETER_PLUGIN_VERSION}.jar --output ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGIN_VERSION}.jar && \
    java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGIN_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller && \
    chmod +x ${JMETER_HOME}/bin/PluginsManagerCMD.sh && \
    rm -rf ${JMETER_HOME}/docs && rm -rf ${JMETER_HOME}/printable_docs \
    rm -rf /var/cache/apk/* && \
    chmod a+x /entrypoint.sh && \
    chmod a+x /cleanup.sh

ENTRYPOINT [ "/entrypoint.sh" ]
