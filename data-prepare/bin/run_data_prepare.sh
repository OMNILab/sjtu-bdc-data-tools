#!/bin/bash
set -e

APP_NAME="cn.edu.sjtu.omnilab.emcbdc.PrepareDataJob"
BINJAR="$(dirname $0)/data-prepare-assembly-1.0.jar"

if [ $# -lt 3 ]; then
 echo "Usage: $0 <httplog.in> <movacc.in> <out>"
 exit -1
fi

httplog=$1
movacc=$2
output=$3_$(date +"%y%m%d-%H%M%S")
echo "Output file:" $output

spark-submit2 --class $APP_NAME $BINJAR $httplog $movacc $output

hadoop fs -tail $output/part-00000