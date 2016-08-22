const { request } = require('./ajax')
const { getData } = require('./store')

module.exports = () => {
  // Initialise starting room
  request('POST', 'http://api.project-arklay.com/rooms/start', getData('inventory').itemsUsed, 'room')
}
