import { component } from '../../common-functions'
import updateInventoryUI from '../../inventory-manager'

const closeInventoryUI = () => updateInventoryUI({
  inventoryClasses: ['inventory', 'closed']
})

const closeButton = component({
  type: 'p',
  classes: ['button'],
  content: 'Close Inventory',
  eventListeners: [{event: 'click', function: closeInventoryUI}]
})

export default closeButton
