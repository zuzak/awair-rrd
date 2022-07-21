# awair-rddtool

Basic tooling to generate a graph of sensor values from several Awair Elements.

To initialise an round-robin database, do `./create.sh sensorname.rrd`.

This runs on my cron; in my crontab I have:

```cron
AWAIR_TOKEN=xxx
AWAIR_DEVICES=123:bedroom,456:study,789:kitchen
*/15 * * * * cd ~/rrdtool && bash getData.sh
```
