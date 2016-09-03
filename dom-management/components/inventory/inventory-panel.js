import { component } from '../../common-functions'
import itemList from './item-list'
import itemDetails from './item-details'
import closeButton from './close-button'

const inventoryPanel = ({ inventoryClasses, itemListClasses, itemDetailsClasses, items, item }) => {

  return component({
    type: 'section',
    classes: inventoryClasses || ['hidden'],
    attributes: [{
      key: 'id',
      value: 'inventoryPanel'
    }],
    children: [itemList({ items, itemListClasses }), itemDetails({  itemDetailsClasses, item }), closeButton]
  })
}

export default inventoryPanel
