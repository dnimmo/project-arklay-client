const { request } = require('./api-caller')
const { getData } = require('./store')

const getRoom = slug => request('POST', `http://localhost:8081/rooms/${slug}`, getData('inventory'), 'room')

module.exports = {
  getRoom
}
