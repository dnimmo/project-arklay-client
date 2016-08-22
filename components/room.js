const { request } = require('./ajax')
const { updateData, getData } = require('./store')()
const update = data => updateData('room', data)

module.exports = () => {
  // Initialise starting room
  request('POST', 'http://api.project-arklay.com/rooms/start', getData('inventory').itemsUsed, 'room')

  return {
  }
}
