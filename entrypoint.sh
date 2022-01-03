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

status=0

if [[ $TESTFILE_PATH == *.jmx ]]
then
  echo "Single file specified so only running one test"
  echo "Running jmeter -n -t $TESTFILE_PATH $@"
  jmeter -n -t $TESTFILE_PATH $@
  status=$?
else
  BASEFILE_PATH=$(basename $TESTFILE_PATH)
  echo "Multiple files specified - Running each JMX File"
  for FILE in "$BASEFILE_PATH/*.jmx"
  do
    echo "Running test with $FILE"
    jmeter -n -t $FILE $@
    test_run=$?
    # If any of the previous tests haven't failed
    if [ "$test_run" == "0" ] && [ "$status" == "0" ]
    then
      status=1 # Set one of the tests failing
    fi
    echo "Test $FILE has exited with status code $test_run"
  done
fi

error=0 # Default error status code

[ $status -eq 0 ] && exit 0 || echo "JMeter exited with status code $status" && exit $status
