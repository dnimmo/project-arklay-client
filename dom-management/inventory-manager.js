// Elements that need to be updated
import {
  inventoryToggle,
  inventoryCount,
  inventory,
  itemList,
  closeInventory,
  itemOptions,
  useButton
} from './elements'

import {
  updateText,
  addClass,
  removeClass,
  toggleClass,
  updateClasses,
  clearContents
} from './common-functions'

import { getData } from '../data-management/store'
import {
  addItem,
  useItem
} from '../data-management/inventory'

const toggleInventory = () => toggleClass(inventory, 'hidden')

inventoryToggle.addEventListener('click', toggleInventory)
closeInventory.addEventListener('click', toggleInventory)

function displayInventoryToggle (count) {
  return count > 0
}

function itemCanBeUsed(itemInfo) {
  console.log(getData('room'))
  return getData('room').slug === itemInfo
}

function addItemButton (item) {
  const button = document.createElement('li')
  addClass(button, 'button', 'inv')
  const buttonText = createText(item.displayName)
  const image = createImage(item.image)
  button.appendChild(image)
  button.appendChild(buttonText)
  button.addEventListener('click', listener)

  function listener () {
    // toggleClass(itemOptions, 'hidden')
    // toggleClass(itemList, 'hidden')
    // toggleClass(closeInventory, 'hidden')
    const listener = () => {
      if(itemCanBeUsed(item)) {
        useItem(item.canBeUsedIn)
      } else {
        console.log('item can not be used')
      }
    }
    useButton.onclick = listener
  }

  return button
}

function createText (displayName) {
  const buttonText = document.createElement('p')
  updateText(buttonText, displayName)
  return buttonText
}

function createImage (itemImage) {
  // Need to actually add the image!
  const image = document.createElement('svg')
  const use = document.createElement('use')
  use.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink')
  use.setAttribute('xlink:href', itemImage)
  image.appendChild(use)
  addClass(image, 'item')

  return image
}

const updateInventoryUI = () => {
  clearContents(itemList)
  const inventory = getData('inventory')
  updateText(inventoryCount, inventory.items.length)

  inventory.items.forEach(item =>   itemList.appendChild(addItemButton(item)))

  if (displayInventoryToggle(inventory.items.length)) {
    removeClass(inventoryToggle, 'hidden')
  } else {
    addClass(inventoryToggle, 'hidden')
  }
}

module.exports = {
  updateInventoryUI
}
