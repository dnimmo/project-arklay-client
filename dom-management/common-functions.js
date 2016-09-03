function createElement ({ type, classes, attributes, eventListeners, children, content }) {
  // Type 'none' is only an option because each room processes whether an item exists automatically - this should be possible to remove once the 'examineRoom' functionality is added
  switch(type) {
    case 'none':
      // Don't return anything
      break
    case 'use':
      // This does not work - SVGs are not rendered
      const elementNS = document.createElementNS('http://www.w3.org/2000/svg', 'use')
      elementNS.setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:xlink', 'http://www.w3.org/1999/xlink')
      if (attributes) attributes.forEach(attribute => elementNS.setAttribute(attribute.key, attribute.value))

      return elementNS
      break

    default:
      const element = document.createElement(type)
      if (classes) classes.forEach(classToAdd => element.classList.add(classToAdd))
      if (attributes) attributes.forEach(attribute => element.setAttribute(attribute.key, attribute.value))
      if (eventListeners) eventListeners.forEach(listener => element.addEventListener(listener.event, listener.function))
      if (children) children.filter(child => child.type !== 'none').forEach(child => element.appendChild(createElement(child)))
      if (content) element.innerText = content

      return element
  }
}

// This function does nothing except make the code the rest of the code more readable
const component = ({ type, classes, attributes, eventListeners, children, content }) => {
  return {
    type, classes, attributes, eventListeners, children, content
  }
}

const render = (target, htmlObject) => {
  target.innerHTML = ''
  target.appendChild(createElement(htmlObject))
}

const toggleClass = (element, classToToggle) => element.classList.toggle(classToToggle)

module.exports = {
  component,
  render,
  toggleClass
}
