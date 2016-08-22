const dataStore = {
  inventory: {},
  room: {}
}

const getData = attribute => dataStore[attribute]
const updateData = (type, data) => dataStore[type] = data

module.exports = {
  getData,
  updateData
}
