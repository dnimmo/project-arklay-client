import {
  northButton,
  eastButton,
  westButton,
  southButton
} from './elements'

export const updateText = (element, update) => element.innerText = update
export const addClass = (element, classToAdd) => element.classList.add(classToAdd)
export const removeClass = (element, classToRemove) => element.classList.remove(classToRemove)
export const toggleClass = (element, classToToggle) => element.classList.toggle(classToToggle)
export const clearContents = element => element.innerHTML = ''
