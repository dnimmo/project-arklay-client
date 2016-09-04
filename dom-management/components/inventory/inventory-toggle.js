import { component } from '../../dom-creation'
import renderApp from '../../app-container'

const openInventoryUI = () => renderApp({
  inventoryClasses: ['inventory']
})

const inventoryToggle = inventory => {
  const inventoryToggleClasses = inventory.items.length > 0 ? ['inventory-icon'] : ['hidden']

  const inventoryImage = component({
    type: 'svg',
    classes: inventoryToggleClasses,
    attributes: [{
      key: 'alt',
      value: 'Inventory',
    }],
    children:[component({
      type: 'use',
      attributes: [{
        key: 'xlink:href',
        value: '/images/defs.svg#inventory'
      }]
    })],
    eventListeners:[{event: 'click', function: openInventoryUI}]
  })

  const inventoryCount = component({
    type: 'span',
    classes: ['inventory-count'],
    content: inventory.items.length
  })

  return component({
    type: 'div',
    classes: ['inventory-toggle'],
    children: [inventoryImage, inventoryCount]
  })
}

export default inventoryToggle
