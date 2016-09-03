// Elements that need to be updated
import { inventoryElement } from './elements'
import { component, render } from './dom-creation'
import { getData } from '../data-management/store'
import { addItem, useItem } from '../data-management/inventory'
import { updateItemOptionsUI } from './item-options-manager'
import inventoryToggle from './components/inventory/inventory-toggle'
import inventoryPanel from  './components/inventory/inventory-panel'

const updateInventoryUI = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const inventory = getData('inventory')
  const itemCount = inventory.items.length

  // Don't bother rendering anything if there are no items
  if (itemCount === 0) return

  const inventoryObject = component({
    type: 'div',
    children: [inventoryToggle(inventory), inventoryPanel( {inventoryClasses, itemListClasses, itemDetailsClasses, items: inventory.items, item})]
  })

  render(inventoryElement, inventoryObject)
}

export default updateInventoryUI
