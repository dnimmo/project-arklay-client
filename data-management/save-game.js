const saveGame = data => {
  if(typeof(localStorage) !== 'undefined') {
    localStorage.setItem('dataStore', JSON.stringify(data))
    return true
  } else {
    // Can't save
    return false
  }
}

const loadGame = () => {
  if(typeof(localStorage) !== 'undefined'){
    const saveData = JSON.parse(localStorage.getItem('dataStore'))
    return saveData !== null ? saveData : false
  } else {
    // Can't load
    return false
  }
}

module.exports = {
  saveGame,
  loadGame
}
