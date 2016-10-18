import { component } from '../../dom-creation'
import { getData } from '../../../data-management/store'
import inventoryToggle from './inventory-toggle'
import inventoryPanel from  './inventory-panel'

const inventoryContainer = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const inventory = getData('inventory')

  return component({
    type: 'div',
    children: [inventoryToggle(inventory), inventoryPanel( {inventoryClasses, itemListClasses, itemDetailsClasses, items: inventory.items, item})]
  })
}

export default inventoryContainer
