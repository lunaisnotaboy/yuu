import { BrowserRouter } from 'react-router-dom'
import { setTheme } from '@/theme-init'
import ReactDOM from 'react-dom'
import { App } from '@/App'
import React from 'react'

export const main = async () => {
  setTheme()

  ReactDOM.render(
    <BrowserRouter>
      <App />
    </BrowserRouter>,
    document.getElementById('app')
  )
}
