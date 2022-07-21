const nextUpdate = () => {
  const prevLi = document.getElementById('update')
  const li = document.createElement('li')
  const time = (() => {
    const ms = 15 * 60 * 1000
    const t = new Date(Math.round((new Date()).getTime() / ms) * ms)
    return t.toLocaleTimeString('en', {timeZone: 'UTC', timeStyle: 'short'})
  })()
  li.innerText = `Next update at ${time}.`
  prevLi.after(li)

  // new Date(Math.round(date.getTime() / ms) * ms)

}
const utcOffset = () => {
  const li = document.getElementById('utc')
  const now = new Date()
  const offset = now.getTimezoneOffset()
  utc.innerText = utc.innerText.slice(0,-1) + (() => {
    if (offset === 0) return ', which is your local time.'
    if (offset > 0) return `, which is ${offset / 60}h earlier than you.`
    if (offset < 0) return `, which is ${Math.abs(offset / 60)}h later than you.`
    return '.'
  })()
}
window.onload = () => {
  nextUpdate()
  utcOffset()
}
