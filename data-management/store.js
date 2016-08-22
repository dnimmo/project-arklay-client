// All of the room/inventory data lives in here - all of the updates happen here, and any requests for the data come through here
const dataUpdated = new Event('data-updated')
document.addEventListener('data-updated', (e) => { console.log('update', getData('inventory')) }, false)
const emitUpdateEvent = () => document.dispatchEvent(dataUpdated)

const dataStore = {
  inventory: {},
  room: {}
}

const getData = attribute => dataStore[attribute]

const updateData = (type, data) => {
  // Update data, and emit event if updated data is different from pre-update data
  const preUpdate = getData(type)
  dataStore[type] = data
  const postUpdate = getData(type)
  if (preUpdate !== postUpdate) emitUpdateEvent()
}

module.exports = {
  getData,
  updateData
}
