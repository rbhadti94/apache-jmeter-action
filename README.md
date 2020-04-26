# Apache JMeter Github Action

This action runs a JMeter performance test using a given JMX test file. It will output a log file and a results file.

## Inputs

### `testFilePath`
**Required**: The path to the JMX test file to run with JMeter

### `outputReportsFolder`
**Not Required**: The folder in which the JMeter reports are produced.


## Example usage
```yaml
# Use JMeter to run the JMX test case and produce reports in the "reports/"
# directory in the workspace.
- name: Run JMeter Tests
  uses: rbhadti94/apache-jmeter-action@v0.1.1
  with:
    testFilePath: tests/sample_test.jmx
    outputReportsFolder: reports/
```