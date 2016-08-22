require('./style/main.scss')
import { initialiseInventory } from './data-management/inventory'
import { getRoom } from './data-management/room'
import { updateRoomUI } from './dom-management/room-manager'
import { updateInventoryUI } from './dom-management/inventory-manager'

document.addEventListener('data-updated', updateInventoryUI)
document.addEventListener('data-updated', updateRoomUI)

// Start game
initialiseInventory()
getRoom('start')
