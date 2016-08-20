require('./style/main.scss')
import React from 'react'
import ReactDom from 'react-dom'

const testApp = params => (<div>{params}</div>)
const test2 = () => <span>Hello</span>
                           
ReactDom.render(testApp(test2()), document.getElementById('app'))