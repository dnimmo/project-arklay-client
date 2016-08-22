const { updateData } = require('./store')()

const request = (type, url, body, dataType) => {
  // 'dataType' refers to either 'inventory' or 'room'
  function listener () {
    console.log(`request body was ${body}`)
    console.log(`updating ${dataType} with ${this.responseText}`)
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
