import renderApp from '../dom-management/app-container'
import { saveGame } from './save-game'

const dataStore = {
  inventory: {},
  room: {}
}

const dataUpdatedEvent = new Event('data-updated')
const emitUpdateEvent = () => document.dispatchEvent(dataUpdatedEvent)
const getData = type => dataStore[type]
const getRoom = () => getData('room')
const getInventory = () => getData('inventory')
const updateData = (type, data) => {
  console.log(data)
  dataStore[type] = data
  emitUpdateEvent()
  // saveGame(dataStore)
}

module.exports = {
  getRoom,
  getInventory,
  updateData
}
