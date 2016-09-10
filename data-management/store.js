import renderApp from '../dom-management/app-container'
import { saveGame } from './save-game'

const dataStore = {
  inventory: {},
  room: {}
}

const dataUpdatedEvent = new Event('data-updated')

const emitUpdateEvent = () => document.dispatchEvent(dataUpdatedEvent)

const getData = type => dataStore[type]

const updateData = (type, data) => {
  dataStore[type] = data
  emitUpdateEvent()
  saveGame(dataStore)
}

const createStore = reducer => {
  let state
  let listeners = []

  const getState = () => state

  const dispatch = action => {
    state = reducer(state, action)
  }

  const subscribe = listener => {
    listeners.push(listener)
  }

  // dispatch to initialise state
  dispatch({})

  return {
    getState,
    dispatch,
    subscribe
  }
}

module.exports = {
  getData,
  updateData
}
