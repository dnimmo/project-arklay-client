const { request } = require('./ajax')

module.exports = () => {
  // Initialise inventory
  request('GET', 'http://api.project-arklay.com/inventory/initialise', '', 'inventory')
}
