const { request } = require('./api-caller')
const { getData } = require('./store')

const rootUrl = 'http://api.project-arklay.com/inventory'

const initialiseInventory = () => request('GET', `${rootUrl}/initialise`, '', 'inventory')

const addItem = itemName => request('PATCH', `${rootUrl}/add/${itemName}`, getData('inventory'), 'inventory')

const useItem = itemName => request('PATCH', `${rootUrl}/remove/${itemName}`, getData('inventory'), 'inventory')

module.exports = {
  initialiseInventory,
  addItem,
  useItem
}
