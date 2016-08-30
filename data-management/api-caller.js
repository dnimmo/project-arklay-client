const { updateData } = require('./store')

const request = (type, url, body, dataType) => {
  // 'dataType' refers to either 'inventory' or 'room'
  function listener () {
    requester.removeEventListener('load', listener)
    updateData(dataType, JSON.parse(this.responseText))
  }

  const requester = new XMLHttpRequest()
  requester.addEventListener('load', listener)
  requester.open(type, url)

  if (type === 'POST' || type === 'PATCH') {
    requester.setRequestHeader('content-type', 'application/json')
  }

  requester.send(JSON.stringify(body))
}

module.exports = {
  request
}
