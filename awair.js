const axios = require('axios')

const getURL = (x) => `https://developer-apis.awair.is/v1/users/self/devices/awair-element/${x}/air-data/raw`

const TOKEN = process.env.AWAIR_TOKEN

const x = async (id, rrd) => {
  const url = getURL(id)
  const res = await axios(url, { headers: { Authorization: `Bearer ${TOKEN}` } })
  const data = res.data.data.reverse()
  const ordered = data.map((d) => {
    const sensors = Object.fromEntries((d.sensors.map((x) => [x.comp, x.value])))
    const epoch = Math.round((new Date(d.timestamp)).getTime() / 1000)
    return [
      epoch,
      d.score || 'U',
      sensors.temp || 'U',
      sensors.humid || 'U',
      sensors.co2 || 'U',
      sensors.voc || 'U',
      sensors.pm25 || 'U'
    ]
  })

  ordered.map((datum) => console.log(`rrdtool update ${rrd}.rrd -- ${datum.shift()}@${datum.join(':')}`))
}

const AWAIR_DEVICES = process.env.AWAIR_DEVICES // 1234:kitchen,2345:bedroom

AWAIR_DEVICES.split(',').map((device) => x(...device.split(':')))
