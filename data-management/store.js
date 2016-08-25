// All of the room/inventory data lives in here - all of the updates happen here, and any requests for the data come through here
const dataUpdated = {
  inventory: new Event('data-updated-inventory'),
  room: new Event('data-updated-room')
}
const emitUpdateEvent = type => document.dispatchEvent(dataUpdated[type])

const dataStore = {
  inventory: {},
  room: {}
}

const getData = type => dataStore[type]

const updateData = (type, data) => {
  // Update data, and emit event if updated data is different from pre-update data
  dataStore[type] = JSON.parse(data)
  emitUpdateEvent(type)
}

module.exports = {
  getData,
  updateData
}
