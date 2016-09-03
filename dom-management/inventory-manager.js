// Elements that need to be updated
import {
  inventoryToggle,
  inventoryCount,
  inventoryElement,
  itemList,
  closeInventory
} from './elements'

import {
  component,
  render,
  toggleClass
} from './common-functions'

import { getData } from '../data-management/store'

import {
  addItem,
  useItem
} from '../data-management/inventory'

import { updateItemOptionsUI } from './item-options-manager'

const getInventoryUI = () => document.getElementById('inventoryPanel')
const openInventoryUI = () => getInventoryUI().classList.remove('hidden')
const closeInventoryUI = () => getInventoryUI().classList.add('hidden')

// const toggleInventory = () => toggleClass(inventory, 'hidden')
//
// inventoryToggle.addEventListener('click', toggleInventory)
// closeInventory.addEventListener('click', toggleInventory)
//
// function itemCanBeUsed(itemInfo) {
//   console.log(getData('room'))
//   return getData('room').slug === itemInfo
// }

function createItemButton (item) {
  const updateItemOptions = () => updateItemOptionsUI(item)


  // button.appendChild(image)

  return component({
    type: 'li',
    classes: ['button', 'inv'],
    content: item.displayName,
    eventListeners: [{event: 'click', function: updateItemOptions}]
  })
}

// function createText (displayName) {
//   const buttonText = document.createElement('p')
//   updateText(buttonText, displayName)
//   return buttonText
// }
//
// function createImage (itemImage) {
//   // Need to actually add the image!
//   const image = document.createElement('svg')
//   const use = document.createElement('use')
//   use.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink')
//   use.setAttribute('xlink:href', itemImage)
//   image.appendChild(use)
//   addClass(image, 'item')
//
//   return image
// }

const updateInventoryUI = () => {
  const inventory = getData('inventory')
  const itemCount = inventory.items.length

  // Don't bother rendering anything if there are no items
  if (itemCount === 0) return

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

  const inventoryToggle = component({
    type: 'div',
    classes: ['inventory-toggle'],
    children: [inventoryImage, inventoryCount]
  })

  const itemButtons = inventory.items.map(item => createItemButton(item))

  const items = component({
    type: 'ul',
    classes: ['itemLIst'],
    children: itemButtons
  })

  const closeButton = component({
    type: 'p',
    classes: ['button'],
    content: 'Close Inventory',
    eventListeners: [{event: 'click', function: closeInventoryUI}]
  })

  const inventoryPanel = component({
    type: 'section',
    classes: ['inventory', 'hidden'],
    attributes: [{
      key: 'id',
      value: 'inventoryPanel'
    }],
    children: [items, closeButton]
  })

  const inventoryObject = component({
    type: 'div',
    children: [inventoryToggle, inventoryPanel]
  })

  render(inventoryElement, inventoryObject)
}

module.exports = {
  updateInventoryUI
}
