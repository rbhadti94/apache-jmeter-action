#!/bin/sh

# Export JAVA_HOME Variable within Entrypoint
export JAVA_HOME="/usr/lib/jvm/java-9-openjdk"
echo "dependency folder = ${DEPENDENCY_FOLDER}"
echo "plugins = ${PLUGINS}"

cp ${DEPENDENCY_FOLDER}/*.jar ${JMETER_HOME}/lib/

jmeter $@
