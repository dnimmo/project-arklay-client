require('./style/main.scss')
import {
  initialiseInventory
} from './data-management/inventory'
import { getRoom } from './data-management/room'
import { updateRoomUI } from './dom-management/room-manager'
import { updateInventoryUI } from './dom-management/inventory-manager'
import { loadGame as load } from './data-management/save-game'
import { updateData } from './data-management/store'

document.addEventListener('data-updated-inventory', updateInventoryUI)
document.addEventListener('data-updated-room', updateRoomUI)

function startNewGame () {
  initialiseInventory()
  getRoom('start')
}

function loadGame ({room, inventory}) {
  updateData('inventory', inventory)
  updateData('room', room)
}

// Start game
const loadedData = load()
console.log(loadedData)
loadedData ? loadGame(loadedData) : startNewGame()
