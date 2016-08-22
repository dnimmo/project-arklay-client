const { updateData, getDataStore } = require('./store')()
const update = data => updateData('inventory', data)

module.exports = () => {
  let gameInventory
  
  (function initialiseInventory () {
    function listener () {
      update(this.responseText)
    }

    const requester = new XMLHttpRequest()
    requester.addEventListener('load', listener)
    requester.open('GET', 'http://api.project-arklay.com/inventory/initialise')
    requester.send()
  })()
  
  const updateInventory = () => {
    
  }
  
  return {
    gameInventory
  }
}