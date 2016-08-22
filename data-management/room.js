const { request } = require('./ajax')
const { getData } = require('./store')

const getRoom = slug => request('POST', `http://api.project-arklay.com/rooms/${slug}`, getData('inventory').itemsUsed, 'room')

module.exports = {
  getRoom
}
