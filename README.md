# Apache JMeter Github Action

This action runs a JMeter performance test using a given JMX test file. It will output a log file and a results file.

## Inputs

### `testFilePath`
**Required**: The path to the JMX test file to run with JMeter

### `outputLogFilePath`
**Not Required**: The output file which will hold the JMeter log after the test run.

**Default**: jmeter_output.log
### `outputResultsPath`
**Not Required**: The output file which will hold the JMeter results after the test run.

**Default**: jmeter_results.log

## Example usage
```yaml
- name: Run JMeter Tests
  uses: rbhadti94/apache-jmeter-action@v0.1.0
  with:
    testFilePath: tests/sample_test.jmx
    outputLogFilePath: my_jmeter_log.log
    outputResultsPath: my_results.log
```