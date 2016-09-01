const { request } = require('./api-caller')
const { getData } = require('./store')

const rootUrl = 'http://api.project-arklay.com/rooms'

const getRoom = slug => request('POST', `${rootUrl}/${slug}?${Date.now()}`, getData('inventory').itemsUsed, 'room')

module.exports = {
  getRoom
}
