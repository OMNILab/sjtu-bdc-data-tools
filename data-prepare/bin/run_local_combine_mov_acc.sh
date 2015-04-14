#!/bin/bash
set -e

if [ $# -lt 3 ]; then
 echo "Usage: local_test.sh <wifimov.in> <account.in> <out>"
 exit -1
fi

APP_NAME="cn.edu.sjtu.omnilab.emcbdc.CombineMovAccJob"
BINJAR="target/scala-2.10/data-prepare-assembly-1.0.jar"

output=$3_$(date +"%y%m%d-%H%M%S")
echo "Output file:" $output

# build with java 6 to be compatible with our Spark cluster
sbt -java-home $(/usr/libexec/java_home -v '1.6*') assembly

spark-submit --master local --class $APP_NAME $BINJAR $1 $2 $output

if [ -d $output ]; then
    echo "Output: "
    head -n 20 $output/part-00000
    echo "..."
fi
