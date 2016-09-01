function createElement ({ type, classes, attributes, eventListeners, children, content }) {
  const element = document.createElement(type)
  if (classes) classes.forEach(classToAdd => element.classList.add(classToAdd))
  if (attributes) attributes.forEach(attribute => element.setAttribute(attribute.key, attribute.value))
  if (eventListeners) eventListeners.forEach(listener => element.addEventListener(listener.event, listener.function))
  if (children) children.forEach(child => element.appendChild(createElement(child)))
  if (content) element.innerText = content

  return element
}

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
