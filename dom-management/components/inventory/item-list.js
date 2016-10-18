import { component } from '../../dom-creation'
import itemButtons from './item-buttons'

const itemList = ({ itemListClasses, items }) => component({
  type: 'ul',
  classes: itemListClasses || ['item-list'],
  children: itemButtons(items)
})

export default itemList
