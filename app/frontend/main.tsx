import ReactDOM from 'react-dom'
import React from 'react'

export const main = () => {
  ReactDOM.render(
    <React.StrictMode>
      <h1>Hello, World!</h1>
    </React.StrictMode>,
    document.getElementById('app')
  )
}
