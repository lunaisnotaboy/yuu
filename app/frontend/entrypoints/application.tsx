import { createInertiaApp } from '@inertiajs/inertia-react'
import { InertiaProgress } from '@inertiajs/progress'
import Layout from '@/components/Layout'
import { render } from 'react-dom'
import React from 'react'

const pages = import.meta.glob('../pages/*.tsx')

document.addEventListener('DOMContentLoaded', () => {
  InertiaProgress.init()

  createInertiaApp({
    resolve: async name => {
      const page = (await pages[`../pages/${name}.tsx`]() as any).default
      page.layout = page.layout || Layout

      return page
    },
    setup({ el, App, props }) {
      render(
        <React.StrictMode>
          <App {...props} />
        </React.StrictMode>,
        el
      )
    }
  })
})
