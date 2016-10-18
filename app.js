require('./style/main.scss')
import { initialiseInventory } from './data-management/inventory'
import getRoom from './data-management/room'
import renderApp from './dom-management/app-container'
import { loadGame as load } from './data-management/save-game'
import { updateData } from './data-management/store'

document.addEventListener('data-updated', renderApp)

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
loadedData ? loadGame(loadedData) : startNewGame()
