#! /bin/sh
mkdir -p graphs/{hour,day,week,month,year}/{0.5,1,2,5,10}

PERIODS=(hour day week month year)
ZOOMS=(1 2 5 10 0.5)

HEIGHT=200
WIDTH=600

# Colours:
k=#048
b=#da3
s=#b56
a=#000

    rrdtool graphv "graphs/favicon.png" \
      --alt-autoscale \
      --end now \
      --upper-limit 100 \
      --lower-limit 0 \
      --rigid \
      --full-size-mode \
      --only-graph \
      --height 16 \
      --start now-1day\
      --width 16 \
      "DEF:b=bedroom.rrd:score:AVERAGE" \
      "DEF:k=kitchen.rrd:score:AVERAGE" \
      "DEF:s=study.rrd:score:AVERAGE" \
      "AREA:b#0f0" \
      "AREA:k#0f0" \
      "AREA:s#0f0"
    exit 0

for period in "${PERIODS[@]}"
do
  for zoom in "${ZOOMS[@]}"
  do
    rrdtool graph "graphs/$period/$zoom/score.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --start now-1$period \
      --title "IAQ score" \
      --units-exponent 0 \
      --vertical-label "%" \
      --width $WIDTH \
      --zoom $zoom \
      "DEF:b=bedroom.rrd:score:AVERAGE" \
      "DEF:k=kitchen.rrd:score:AVERAGE" \
      "DEF:s=study.rrd:score:AVERAGE" \
      "AREA:1000#efe:skipscale" \
      "AREA:80#fff:skipscale" \
      "LINE1:b$b" \
      "LINE1:k$k" \
      "LINE1:s$s"

    rrdtool graph "graphs/$period/$zoom/temp.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --start now-1$period \
      --title "air temperature" \
      --units-exponent 0 \
      --vertical-label "°C" \
      --width $WIDTH \
      --zoom $zoom \
      "DEF:b=bedroom.rrd:temp:AVERAGE" \
      "DEF:k=kitchen.rrd:temp:AVERAGE" \
      "DEF:s=study.rrd:temp:AVERAGE" \
      "CDEF:a=s,k,+,b,+,3,/" \
      "AREA:24.5#efe:skipscale" \
      "AREA:17.5#fff:skipscale" \
      "HRULE:20#ffa" \
      "LINE1:k$k" \
      "LINE1:b$b" \
      "LINE1:s$s" \
      "LINE1:a$a"

    rrdtool graph "graphs/$period/$zoom/humid.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --start now-1$period \
      --title "relative humidity" \
      --units-exponent 0 \
      --vertical-label "%" \
      --width $WIDTH \
      --zoom $zoom \
      "DEF:b=bedroom.rrd:humid:AVERAGE" \
      "DEF:k=kitchen.rrd:humid:AVERAGE" \
      "DEF:s=study.rrd:humid:AVERAGE" \
      "AREA:42#efe:skipscale" \
      "AREA:50.5#efe:skipscale" \
      "LINE1:b$b" \
      "LINE1:k$k" \
      "LINE1:s$s"

    rrdtool graph "graphs/$period/$zoom/voc.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --lower-limit 20 \
      --start now-1$period \
      --title "total volatile organic compounds" \
      --units-exponent 0 \
      --vertical-label "parts per billion" \
      --width $WIDTH \
      --zoom $zoom \
      "DEF:b=bedroom.rrd:voc:AVERAGE" \
      "DEF:k=kitchen.rrd:voc:AVERAGE" \
      "DEF:s=study.rrd:voc:AVERAGE" \
      "AREA:345#efe:skipscale" \
      "LINE1:b$b" \
      "LINE1:k$k" \
      "LINE1:s$s" \
      "HRULE:20#444:dashes" \
      "HRULE:36000#444:dashes"

    rrdtool graph "graphs/$period/$zoom/pm25.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --start now-1$period \
      --title "particulate matter ≤2.5μm" \
      --units-exponent 0 \
      --vertical-label "µg/m³" \
      --width $WIDTH \
      --zoom $zoom \
      "DEF:b=bedroom.rrd:pm25:AVERAGE" \
      "DEF:k=kitchen.rrd:pm25:AVERAGE" \
      "DEF:s=study.rrd:pm25:AVERAGE" \
      "AREA:15.5#efe:skipscale" \
      "LINE1:b$b" \
      "LINE1:k$k" \
      "LINE1:s$s" \
      "HRULE:1000#444:dashes"

    rrdtool graph "graphs/$period/$zoom/co2.png" \
      --alt-autoscale \
      --end now \
      --full-size-mode \
      --height $HEIGHT \
      --start now-1$period \
      --title "CO₂" \
      --vertical-label "parts per million" \
      --units-exponent 0 \
      --width $WIDTH \
      --zoom $zoom \
      --lower-limit 400 \
      "DEF:b=bedroom.rrd:co2:AVERAGE" \
      "DEF:k=kitchen.rrd:co2:AVERAGE" \
      "DEF:s=study.rrd:co2:AVERAGE" \
      "AREA:600.5#efe" \
      "HRULE:400#444:dashes" \
      "HRULE:5000#444:dashes" \
      "LINE1:b$b" \
      "LINE1:k$k" \
      "LINE1:s$s"
  done
done
