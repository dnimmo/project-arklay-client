const { updateData } = require('./store')

const request = (type, url, body, dataType) => {
  // 'dataType' refers to either 'inventory' or 'room'
  function listener () {
    requester.removeEventListener('load', listener)
    updateData(dataType, this.responseText)
  }

  const requester = new XMLHttpRequest()
  requester.addEventListener('load', listener)
  requester.open(type, url)
  requester.send(body)
}

module.exports = {
  request
}
