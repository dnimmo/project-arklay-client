require('./style/main.scss')
require('./data-management/inventory')()
import { getRoom } from './data-management/room'

import { tempManager } from './dom-management/room-manager'

tempManager()
getRoom('start')
