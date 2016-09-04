import { saveGame } from './save-game'

const dataStore = {
  inventory: {},
  room: {}
}

const dataUpdatedEvent = new Event('data-updated')

const emitUpdateEvent = () => document.dispatchEvent(dataUpdatedEvent)

const getData = type => dataStore[type]

const updateData = (type, data) => {
  dataStore[type] = data
  emitUpdateEvent()
  saveGame(dataStore)
}

module.exports = {
  getData,
  updateData
}
