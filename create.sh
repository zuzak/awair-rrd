#!/bin/sh
rrdtool create $1 \
  --start 1658149100 \
  --step 10 \
  "DS:score:GAUGE:10:0:100" \
  "DS:temp:GAUGE:10:-40:100" \
  "DS:humid:GAUGE:10:0:100" \
  "DS:co2:GAUGE:10:400:U" \
  "DS:voc:GAUGE:10:0:U" \
  "DS:pm25:GAUGE:10:0:U" \
  "RRA:AVERAGE:0.5:1:8640" \
  "RRA:AVERAGE:0.5:3:20160" \
  "RRA:AVERAGE:0.5:6:10080" \
  "RRA:AVERAGE:0.5:360:87600"
