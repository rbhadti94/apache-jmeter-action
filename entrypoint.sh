#!/bin/sh

# Export JAVA_HOME Variable within Entrypoint
export JAVA_HOME="/usr/lib/jvm/java-9-openjdk"

if [ -n "$DEPENDENCY_FOLDER" ]
then
  cp ${GITHUB_WORKSPACE}/${DEPENDENCY_FOLDER}/*.jar ${JMETER_HOME}/lib/
fi

if [ -n "$PLUGINS" ]
then
  pluginArray=$(echo $PLUGINS | tr "," "\n")
  for plugin in $pluginArray
  do
    ${JMETER_HOME}/bin/PluginsManagerCMD.sh install $plugin
    [ $? -eq 0 ] || exit 1
  done
fi

jmeter $@
status=$?
[ $status -eq 0 ] || echo "JMeter exited with status code $status" && exit 1
