const { request } = require('./ajax')
const { updateData, getData } = require('./store')()
const update = data => updateData('inventory', data)

module.exports = () => {
  // Initialise inventory
  request('GET', 'http://api.project-arklay.com/inventory/initialise', '', 'inventory')

  return {
    // gameInventory
  }
}
