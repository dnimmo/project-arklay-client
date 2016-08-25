const { request } = require('./api-caller')
const { getData } = require('./store')

const initialiseInventory = () => request('GET', 'http://api.project-arklay.com/inventory/initialise', '', 'inventory')

const addItem = itemName => request('PATCH', `http://api.project-arklay.com/inventory/add/${itemName}`, getData('inventory'), 'inventory')

module.exports = {
  initialiseInventory,
  addItem
}
