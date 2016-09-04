import { component } from '../../dom-creation'
import renderApp from '../../app-container'

const closeInventoryUI = () => renderApp({
  inventoryClasses: ['inventory', 'closed']
})

const closeButton = component({
  type: 'p',
  classes: ['button'],
  content: 'Close Inventory',
  eventListeners: [{event: 'click', function: closeInventoryUI}]
})

export default closeButton
