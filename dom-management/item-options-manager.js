import {
  itemOptions,
  itemList,
  itemName,
  closeInventory,
  itemDescription,
  useItemButton,
  itemUsedMessage,
  itemNotUsedMessage
} from './elements'

import {
  updateText,
  toggleClass,

} from './common-functions'

import { getRoom } from '../data-management/room'
import { getData } from '../data-management/store'
import { useItem } from '../data-management/inventory'

function canItemBeUsed (item, slug) {
  return item === slug
}

const updateItemOptionsUI = ({name, displayName, description, canBeUsedIn, messageWhenNotUsed, messageWhenUsed}) => {
  updateText(itemName, displayName)
  updateText(itemDescription, description)
  toggleClass(itemOptions, 'hidden')
  toggleClass(itemList, 'hidden')
  toggleClass(closeInventory, 'hidden')

  function listener () {
    if (canItemBeUsed(canBeUsedIn, getData('room').slug)) {
      useItem(name)
      // update room now that item has been used
      getRoom(getData('room').slug)
      // close the inventory
      toggleClass(itemOptions, 'hidden')
      toggleClass(itemList, 'hidden')
      toggleClass(closeInventory, 'hidden')
      toggleClass(inventory, 'hidden')
    } else {
      updateText(itemNotUsedMessage, `==${messageWhenNotUsed}==`)
    }
  }

  // Override onclick event with whichever item has been selected
  useItemButton.onclick = listener
}

module.exports = {
  updateItemOptionsUI
}
