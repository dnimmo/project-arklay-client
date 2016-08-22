module.exports = () => {
  const dataStore = {
    inventory: {},
    room: {}
  }
  
  const getDataStore = () => dataStore
  
  const updateData = (type, data) => {  
    console.log('type', type)
    switch(type) {
    case 'inventory':
      dataStore.inventory = data
      break
      case 'room':
      dataStore.room = data
      break
    }
    console.log(dataStore)
  }
  
  return {
    getDataStore,
    updateData
  }
}