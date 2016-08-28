const dataStore = {
  inventory: {},
  room: {}
}

const dataUpdated = {
  inventory: new Event('data-updated-inventory'),
  room: new Event('data-updated-room'),
  item: new Event('data-updated-item')
}

const emitUpdateEvent = type => document.dispatchEvent(dataUpdated[type])

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
