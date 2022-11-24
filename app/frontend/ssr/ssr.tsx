import { createInertiaApp } from '@inertiajs/inertia-react'
import cjsCreateServer from '@inertiajs/server'
import ReactDOMServer from 'react-dom/server'

const createServer = typeof cjsCreateServer === 'function' ? cjsCreateServer : (cjsCreateServer as any).default
const pages = (import.meta as any).globEagerDefault('../pages/*.tsx')

createServer((page: any) => createInertiaApp({
  page,
  render: ReactDOMServer.renderToString,
  resolve: name => pages[`../pages/${name}.tsx`],
  setup: ({ App, props }) => <App {...props} />
}))
