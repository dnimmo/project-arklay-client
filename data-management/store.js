// All of the room/inventory data lives in here - all of the updates happen here, and any requests for the data come here
const dataUpdated = new Event('data-updated')
document.addEventListener('data-updated', (e) => { console.log('update', getData('inventory')) }, false)
const emitUpdateEvent = () => document.dispatchEvent(dataUpdated)

const dataStore = {
  inventory: {},
  room: {}
}

const getData = attribute => dataStore[attribute]
const updateData = (type, data) => {
  dataStore[type] = data
  emitUpdateEvent()
}

module.exports = {
  getData,
  updateData
}
