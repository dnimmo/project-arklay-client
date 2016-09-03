import { component } from '../../common-functions'
import itemButtons from './item-buttons'

const itemList = ({ itemListClasses, items }) => component({
  type: 'ul',
  classes: itemListClasses || ['item-list'],
  children: itemButtons(items)
})

export default itemList
