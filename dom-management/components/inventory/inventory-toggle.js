import { component } from '../../dom-creation'
import updateInventoryUI from '../../inventory-manager'

const openInventoryUI = () => updateInventoryUI({
  inventoryClasses: ['inventory']
})

const inventoryToggle = inventory => {
  const inventoryImage = component({
    type: 'svg',
    classes: ['inventory-icon'],
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
