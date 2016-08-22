const { updateData, getDataStore } = require('./store')()
const update = data => updateData('room', data)

module.exports = () => {
  let gameInventory
  
  (function initialiseInventory () {
    function listener () {
      update(this.responseText)
    }

    const requester = new XMLHttpRequest()
    requester.addEventListener('load', listener)
    requester.open('POST', 'http://api.project-arklay.com/rooms/start')
    requester.send(getDataStore().inventory.itemsUsed)
  })()

  const updateInventory = () => {
    
  }
  
  return {
    gameInventory
  }
}