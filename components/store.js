module.exports = () => {
  const dataStore = {
    inventory: {},
    room: {}
  }

  const getData = attribute => dataStore[attribute]

  const updateData = (type, data) => {
    dataStore[type] = data
  }

  return {
    getData,
    updateData
  }
}
