// Elements that need to be updated
import {
  roomDescription,
  roomDetails,
  directions
} from './elements'

const tempManager = () => {
  const updateText = (element, update) => element.innerText = update
  const addClass = (element, classToAdd) => element.classList.add(classToAdd)
  const removeClass = (element, classToRemove) => element.classList.remove(classToRemove)
  const toggleClass = (element, classToToggle) => element.classList.toggle(classToToggle)

  const toggleInventory = () => toggleClass(inventory, 'hidden')

  inventoryToggle.addEventListener('click', toggleInventory)
  closeInventory.addEventListener('click', toggleInventory)

  updateText(roomDescription, 'hello!')
  updateText(roomDetails, 'goodbye!')
}

module.exports = {
  tempManager
}
