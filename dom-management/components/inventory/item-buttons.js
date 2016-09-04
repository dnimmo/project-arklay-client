import { component } from '../../dom-creation'
import renderApp from '../../app-container'

const itemButtons = items => {
  function createItemButton (item) {
    const openItemOptions = () => renderApp({inventoryClasses: ['inventory', 'open'], itemListClasses: ['hidden'], itemDetailsClasses: ['item-details'], item})

    return component({
      type: 'li',
      classes: ['button', 'inv'],
      content: item.displayName,
      eventListeners: [{event: 'click', function: openItemOptions}]
    })
  }

  return items.map(item => createItemButton(item))
}

export default itemButtons
