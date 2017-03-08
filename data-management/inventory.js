import request from './api-caller'
import { getInventory } from './store'

const rootUrl =  'http://localhost:8081/inventory' // 'http://api.project-arklay.com/inventory'

const initialiseInventory = () => request('GET', `${rootUrl}/initialise`, '', 'inventory')
const addItem = itemName => request('PATCH', `${rootUrl}/add/${itemName}`, getInventory(), 'inventory')
const useItem = itemName => request('PATCH', `${rootUrl}/remove/${itemName}`, getInventory(), 'inventory')

const hasItemBeenPickedUp = itemName => {
  const inventory = getInventory()
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
