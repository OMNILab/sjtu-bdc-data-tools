#!/bin/bash
set -e

APP_NAME="cn.edu.sjtu.omnilab.emcbdc.CleanseWIFILogJob"
BINJAR="target/scala-2.10/data-prepare-assembly-1.0.jar"

if [ $# -lt 2 ]; then
 echo "Usage: $0 <in> <out>"
 exit -1
fi

input=$1
output=$2_$(date +"%y%m%d-%H%M%S")
echo "Output file:" $output

# build with java 6 to be compatible with our Spark cluster
sbt -java-home $(/usr/libexec/java_home -v '1.6*') assembly

spark-submit --master local --class $APP_NAME $BINJAR $input $output

if [ -d $output ]; then
    echo "Output: "
    head -n 20 $output/part-00000
    echo "..."
fi
