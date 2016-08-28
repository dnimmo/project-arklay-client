// Elements that need to be updated
import {
  inventoryToggle,
  inventoryCount,
  inventory,
  itemList,
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

function addItemButton (item) {
  const button = document.createElement('li')
  addClass(button, 'button', 'inv')
  const buttonText = createText(item)
  const image = createImage(item)
  button.appendChild(image)
  button.appendChild(buttonText)
  button.addEventListener('click', listener)

  function listener () {
    console.log('clicked')
  }

  return button
}

function createText (item) {
  const buttonText = document.createElement('p')
  updateText(buttonText, item)
  return buttonText
}

function createImage (item) {
  // Need to actually add the image!
  const image = document.createElement('svg')
  const use = document.createElement('use')
  use.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink')
  use.setAttribute('xlink:href', item)
  image.appendChild(use)
  addClass(image, 'item')

  return image
}

const updateInventoryUI = () => {
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
