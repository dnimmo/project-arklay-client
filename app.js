require('./style/main.scss')
import { initialiseInventory } from './data-management/inventory'
import { getRoom } from './data-management/room'
import { updateRoomUI } from './dom-management/room-manager'
import { updateInventoryUI } from './dom-management/inventory-manager'
import { loadGame } from './data-management/save-game.js'

document.addEventListener('data-updated-inventory', updateInventoryUI)
document.addEventListener('data-updated-room', updateRoomUI)

// Start game
const loadData = loadGame()
if (loadData) {
  initialiseInventory(loadData.inventory)
  getRoom(loadData.room.slug)
} else {
  initialiseInventory()
  getRoom('start')
}
