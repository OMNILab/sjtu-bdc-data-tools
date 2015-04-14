#!/bin/bash
set -e

APP_NAME="cn.edu.sjtu.omnilab.emcbdc.CombineJaccJob"
BINJAR="$(dirname $0)/data-prepare-assembly-1.0.jar"

if [ $# -lt 3 ]; then
 echo "Usage: $0 <wifilog.in> <jacc.in> <out>"
 exit -1
fi

output=$3_$(date +"%y%m%d-%H%M%S")
echo "Output file:" $output

spark-submit2 --class $APP_NAME $BINJAR $1 $2 $output

hadoop fs -tail $output/part-00000
