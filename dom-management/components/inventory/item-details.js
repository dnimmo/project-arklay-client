import { component } from '../../dom-creation'
import updateInventoryUI from '../../inventory-manager'

const keepOpenInventoryUI = () => updateInventoryUI({
  inventoryClasses: ['inventory', 'open'],
  itemDetailsClasses: ['hidden']
})

const itemDetails = ({itemDetailsClasses, item}) => {
  const useItemButton = component({
    type: 'li',
    classes: ['button'],
    content: 'Use'
  })

  const cancelButton = component({
    type: 'li',
    classes: ['button'],
    content: 'Cancel',
    eventListeners: [{event: 'click', function: keepOpenInventoryUI}]
  })

  const itemOptions = component({
    type: 'ul',
    classes: ['itemOptions'],
    children: [useItemButton, cancelButton]
  })

  return component({
    type: 'div',
    classes: itemDetailsClasses || ['hidden'],
    children: [component({
      type: 'p',
      content: item.displayName
    }), component({
      type: 'p',
      content: item.description
    }), itemOptions]
  })

}

export default itemDetails
