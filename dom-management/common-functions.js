function createElement ({type, classes, attributes, children, content}) {
  const element = document.createElement(type)
  if (classes) classes.forEach(classToAdd => element.classList.add(classToAdd))
  if (attributes) attributes.forEach(attribute => element.setAttribute(attribute.key, attribute.value))
  if (children) children.forEach(child => element.appendChild(createElement(child)))
  if (content) element.innerText = content

  return element
}

const component = (type, classes, attributes, children, content) => {
  return {
    type, classes, attributes, children, content
  }
}

const render = (target, htmlObject) => target.appendChild(createElement(htmlObject))

const toggleClass = (element, classToToggle) => element.classList.toggle(classToToggle)

module.exports = {
  component,
  render,
  toggleClass
}
