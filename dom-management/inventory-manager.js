// Elements that need to be updated
import {
  inventoryToggle,
  inventory,
  closeInventory
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass
} from './common-functions'

import { getData } from '../data-management/store'
import { addItem } from '../data-management/inventory'

const toggleInventory = () => toggleClass(inventory, 'hidden')

inventoryToggle.addEventListener('click', toggleInventory)
closeInventory.addEventListener('click', toggleInventory)

const updateInventoryUI = () => {

  if (inventory['items'] && inventory.items.length > 0) {
    removeClass(inventoryToggle, 'hidden')
  } else {
    addClass(inventoryToggle, 'hidden')
  }
}

module.exports = {
  updateInventoryUI
}
