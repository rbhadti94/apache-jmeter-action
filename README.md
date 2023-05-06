![Test Action](https://github.com/rbhadti94/apache-jmeter-action/workflows/Test%20Action/badge.svg)

# Apache JMeter Github Action

This action runs a JMeter performance test using a given JMX test file. It will output a log file and a results file.

## Inputs

### `testFilePath`
**Required**: The path to the JMX test file to run with JMeter. Can also specify a folder, in which case all JMX files in that folder will be run.

### `outputReportsFolder`
**Not Required**: The folder in which the JMeter reports are produced.

### ```args``` - Optional Arguments
**Not Required**: Additional arguments to pass to JMeter. In the format

```bash
--flag <argument>
# OR
--flag <argument>=<value>
```

Please see https://jmeter.apache.org/usermanual/get-started.html for more information on the possible arguments

## Example usage
```yaml
# Use JMeter to run the JMX test case and produce reports in the "reports/"
# directory in the workspace.
- name: Run JMeter Tests
  uses: rbhadti94/apache-jmeter-action@v0.5.0
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/

# Use JMeter to run the JMX test case.
# Modify the logging level and pass in some custom properties and config
- name: Run JMeter Tests with modified logging and custom properties
  uses: rbhadti94/apache-jmeter-action@v0.5.0
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/
    args: "--loglevel INFO -JMyProperty=Value --jmeterlogconf=log.conf"

- name: Run JMeter Tests plugins
  uses: rbhadti94/apache-jmeter-action@v0.5.0
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/
    args: "--loglevel INFO -JMyProperty=Value --jmeterlogconf=log.conf"
    plugins: ""

# Use JMeter to run all tests in a folder
# Modify the logging level and pass in some custom properties and config
- name: Run All JMeter Tests In tests Folder
  uses: rbhadti94/apache-jmeter-action@v0.5.0
  with:
    testFilePath: tests/
    outputReportsFolder: reports/
    args: "--loglevel INFO -JMyProperty=Value --jmeterlogconf=log.conf"
```

### Full Example Usage
Use JMeter to run the JMX test case and produce reports in the "reports/"directory in the workspace.

```yaml
name: Test JMeter Action

on:
  push:
    branches:
      - master
  pull_request:
    branches: [master]

jobs:
  action_build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Run JMeter Action on a test
        uses: rbhadti94/apache-jmeter-action@v0.5.0
        with:
          testFilePath: tests/sample_test.jmx
          outputReportsFolder: reports/
          args: "--loglevel INFO"

      - name: Run JMeter Action on other tests
        uses: rbhadti94/apache-jmeter-action@v0.5.0
        with:
          testFilePath: other-tests/
          outputReportsFolder: other_reports/
          args: "--loglevel INFO"

      - uses: actions/upload-artifact@v1
        with:
          name: jmeter-test-results
          path: reports/

      - uses: actions/upload-artifact@v1
        with:
          name: jmeter-test-results-other
          path: other_reports/
```