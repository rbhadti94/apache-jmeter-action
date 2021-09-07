#!/bin/sh

# Export JAVA_HOME Variable within Entrypoint
export JAVA_HOME="/usr/lib/jvm/java-9-openjdk"
echo "dependency folder = ${DEPENDENCY_FOLDER}"
echo "plugins = ${PLUGINS}"

cp ${GITHUB_WORKSPACE}/${DEPENDENCY_FOLDER}/*.jar ${JMETER_HOME}/lib/
[ $? -eq 0 ]  || exit 1
ls ${JMETER_HOME}/lib

pluginArray=$(echo $PLUGINS | tr "," "\n")
for plugin in $pluginArray
do
  ${JMETER_HOME}/bin/PluginsManagerCMD.sh install $plugin
  [ $? -eq 0 ]  || exit 1
done

jmeter $@
status=$?
echo "status=$status"
[ $status -eq 0 ] || echo "JMeter exited with status code $status" && exit 1
