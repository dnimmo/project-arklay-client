import { component } from '../../dom-creation'
import { addItem, hasItemBeenPickedUp } from '../../../data-management/inventory'

function processItem (item, itemName) {
  if (!item || hasItemBeenPickedUp(item)) return {type: 'none'}
  addItem(item)

  return component({
    type: 'p',
    classes: ['additional-info', 'extra-message'],
    content: `== ${itemName} added to inventory ==`
  })
}

const itemMessage = item => processItem(item)

export default itemMessage
