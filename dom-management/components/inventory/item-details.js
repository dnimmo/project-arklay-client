import { component } from '../../dom-creation'
import { useItem } from '../../../data-management/inventory'
import { getData } from '../../../data-management/store'
import updateInventoryUI from '../../inventory-manager'

const keepOpenInventoryUI = () => updateInventoryUI({
  inventoryClasses: ['inventory', 'open'],
  itemDetailsClasses: ['hidden']
})

const closeInventoryUI = () => updateInventoryUI({
  inventoryClasses: ['inventory', 'closed']
})

const itemDetails = ({itemDetailsClasses, item}) => {
  const tryItem = () => {
    const room = getData('room')
    if (item.canBeUsedIn === room.slug) {
      closeInventoryUI()
      useItem(item.name)
    } else {
      console.log(false)
    }
  }

  const useItemButton = component({
    type: 'li',
    classes: ['button'],
    content: 'Use',
    eventListeners: [{event: 'click', function: tryItem}]
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
