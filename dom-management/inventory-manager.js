import { component, render } from './dom-creation'
import { getData } from '../data-management/store'
import inventoryToggle from './components/inventory/inventory-toggle'
import inventoryPanel from  './components/inventory/inventory-panel'

const updateInventoryUI = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const inventory = getData('inventory')
  //
  // if (inventory.items.length === 0) inventoryClasses = ['hidden']

  const inventoryObject = component({
    type: 'div',
    children: [inventoryToggle(inventory), inventoryPanel( {inventoryClasses, itemListClasses, itemDetailsClasses, items: inventory.items, item})]
  })

  render(document.getElementById('inventory'), inventoryObject)
}

export default updateInventoryUI
