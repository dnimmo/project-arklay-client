import { component, render } from './dom-creation'
import roomContainer from './components/room/room-container'
import inventoryContainer from './components/inventory/inventory-container'

const appContainer = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {

  return component({
    type: 'div',
    children: [roomContainer(), inventoryContainer( {inventoryClasses, itemListClasses, itemDetailsClasses, item})]
  })
}

const renderApp = ( {inventoryClasses, itemListClasses, itemDetailsClasses, item = {}} ) => {
  const appObject = appContainer( {inventoryClasses, itemListClasses, itemDetailsClasses, item} )

  render(document.getElementById('app'), appObject)
}

export default renderApp
