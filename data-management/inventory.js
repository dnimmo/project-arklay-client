import request from './api-caller'
import { getData } from './store'

const rootUrl = 'http://api.project-arklay.com/inventory'

const initialiseInventory = () => request('GET', `${rootUrl}/initialise`, '', 'inventory')

const addItem = itemName => request('PATCH', `${rootUrl}/add/${itemName}`, getData('inventory'), 'inventory')

const useItem = itemName => request('PATCH', `${rootUrl}/remove/${itemName}`, getData('inventory'), 'inventory')

const hasItemBeenPickedUp = itemName => {
  const inventory = getData('inventory')
  const items = inventory.items
  const itemsUsed = inventory.itemsUsed
  // if items is undefined, then the game has just loaded and hasn't had time to insantiate the items - re-call this function
  // Note this can lead to maximum call stack size being exceeded, not ideal
  return items ? items.map(item => item.name).includes(itemName) || itemsUsed.includes(itemName) : hasItemBeenPickedUp(itemName)
}

module.exports = {
  initialiseInventory,
  addItem,
  useItem,
  hasItemBeenPickedUp
}
