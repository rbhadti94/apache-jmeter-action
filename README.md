![Test Action](https://github.com/rbhadti94/apache-jmeter-action/workflows/Test%20Action/badge.svg)

# Apache JMeter Github Action

This action runs a JMeter performance test using a given JMX test file. It will output a log file and a results file.

## Inputs

### `testFilePath`
**Required**: The path to the JMX test file to run with JMeter

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
  uses: rbhadti94/apache-jmeter-action@v0.3.1
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/

# Use JMeter to run the JMX test case.
# Modify the logging level and pass in some custom properties and config
- name: Run JMeter Tests with modified logging and custom properties
  uses: rbhadti94/apache-jmeter-action@v0.3.1
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/
    args: "--loglevel INFO -JMyProperty=Value --jmeterlogconf=log.conf"
```