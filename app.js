require('./style/main.scss')
import {
  roomDescription,
  roomDetails,
  directions
} from './components/elements'

const updateText = (element, update) => element.innerText = update

updateText(roomDescription, 'hello!')
updateText(roomDetails, 'goodbye!')