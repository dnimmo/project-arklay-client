import request from './api-caller'
import { getInventory } from './store'

const rootUrl = 'http://localhost:8081/rooms' // 'http://api.project-arklay.com/rooms'
const getNewRoom = slug => request('POST', `${rootUrl}/${slug}?${Date.now()}`, getInventory ? getInventory().itemsUsed : [], 'room')

export default getNewRoom
