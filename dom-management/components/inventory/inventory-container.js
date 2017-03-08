import { component } from '../../dom-creation'
import { getInventory } from '../../../data-management/store'
import inventoryToggle from './inventory-toggle'
import inventoryPanel from  './inventory-panel'

const inventoryContainer = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const inventory = getInventory ? getInventory() : { items: [], itemsUsed: [] }

  return component({
    type: 'div',
    children: [inventoryToggle(inventory), inventoryPanel( {inventoryClasses, itemListClasses, itemDetailsClasses, items: inventory.items, item})]
  })
}

export default inventoryContainer
