#!/bin/sh
ls ${{ inputs.outputReportsFolder }}
rm -rf ${{ inputs.outputReportsFolder }}
ls ${{ inputs.outputReportsFolder }}
