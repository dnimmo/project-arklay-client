require('./style/main.scss')
import {
  initialiseInventory,
  initialiseSavedInventory
} from './data-management/inventory'
import { getRoom } from './data-management/room'
import { updateRoomUI } from './dom-management/room-manager'
import { updateInventoryUI } from './dom-management/inventory-manager'
import { loadGame as load } from './data-management/save-game.js'

document.addEventListener('data-updated-inventory', updateInventoryUI)
document.addEventListener('data-updated-room', updateRoomUI)

function startNewGame () {
  initialiseInventory()
  getRoom('start')
}

function loadGame ({room, inventory}) {
  initialiseSavedInventory(inventory)
  getRoom(room.slug)
}

// Start game
const loadedData = load()
loadedData ? loadGame(loadedData) : startNewGame()
