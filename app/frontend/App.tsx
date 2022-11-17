import { LayoutSettingsContextProvider } from '@/contexts/LayoutSettingsContext'
import React, { Suspense } from 'react'
import '@/stylesheets/main.css'

export const App: React.FC = () => {
  return (
    <React.StrictMode>
      <Suspense fallback={null}>
        <LayoutSettingsContextProvider>
          <h1>Hello, World!</h1>
        </LayoutSettingsContextProvider>
      </Suspense>
    </React.StrictMode>
  )
}
