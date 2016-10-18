import { component } from '../../dom-creation'

const roomInfo = ( {description, surroundings} ) => {
  const roomDescription = component({
    type: 'p',
    content: description
  })
  const roomSurroundings = component({
    type: 'p',
    content: surroundings
  })

  return component({
    type: 'div',
    children: [roomDescription, roomSurroundings]
  })
}

export default roomInfo
