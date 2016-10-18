import { component, render } from './dom-creation'
import roomContainer from './components/room/room-container'
import inventoryContainer from './components/inventory/inventory-container'

const appContainer = ( {roomClasses, itemName, inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {

  return component({
    type: 'div',
    children: [roomContainer({roomClasses, itemName}), inventoryContainer( {inventoryClasses, itemListClasses, itemDetailsClasses, item})]
  })
}

const renderApp = ( {roomClasses, itemName, inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const appObject = appContainer( {
    roomClasses,
    inventoryClasses,
    itemListClasses,
    itemDetailsClasses,
    item
  })

  render(document.getElementById('app'), appObject)
}

export default renderApp
