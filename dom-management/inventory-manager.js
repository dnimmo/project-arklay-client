// Elements that need to be updated
import {
  inventoryToggle,
  inventoryCount,
  inventory,
  closeInventory
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass,
  updateClasses
} from './common-functions'

import { getData } from '../data-management/store'
import { addItem } from '../data-management/inventory'

const toggleInventory = () => toggleClass(inventory, 'hidden')

inventoryToggle.addEventListener('click', toggleInventory)
closeInventory.addEventListener('click', toggleInventory)

function displayInventoryToggle (count) {
  return count > 0
}

const updateInventoryUI = () => {
  const inventory = getData('inventory')

  if (displayInventoryToggle(inventory.items.length)) {
    removeClass(inventoryToggle, 'hidden')
  } else {
    addClass(inventoryToggle, 'hidden')
  }
}

module.exports = {
  updateInventoryUI
}
