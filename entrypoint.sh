#!/bin/bash

TESTFILE_PATH=$3

echo "Using Test File Path $TESTFILE_PATH"

# Removing first 3 arguments from Entrypoint. Need to find a better way to do this
set -- "${@:1:0}" "${@:2}"
set -- "${@:1:0}" "${@:2}"
set -- "${@:1:0}" "${@:2}"

echo $@

# Export JAVA_HOME Variable within Entrypoint
export JAVA_HOME="/usr/lib/jvm/java-9-openjdk"

if [ -n "$DEPENDENCY_FOLDER" ]
then
  cp ${GITHUB_WORKSPACE}/${DEPENDENCY_FOLDER}/*.jar ${JMETER_HOME}/lib/
fi

if [ -n "$PLUGINS" ]
then
  echo "$PLUGINS" | tr "," "\n" | parallel -I% --jobs 5 "${JMETER_HOME}/bin/PluginsManagerCMD.sh install %"
fi

if [[ $TESTFILE_PATH == *.jmx ]]
then
  echo "Single file specified so only running one test"
  jmeter -n -t $TESTFILE_PATH $@
  status=$?
else
  echo "Multiple files specified - Running each JMX File"
  for FILE in "$TESTFILE_PATH/*.jmx"
  do
    jmeter -n -t $TESTFILE_PATH $@
  done
fi

error=0 # Default error status code

[ $status -eq 0 ] && exit 0 || echo "JMeter exited with status code $status" && exit $status
