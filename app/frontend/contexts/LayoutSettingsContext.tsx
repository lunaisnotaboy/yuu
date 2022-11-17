import React, { useContext, useEffect, useState } from 'react'
import type { HeaderProps } from '@/components/Header'
import type { PartialDeep } from 'type-fest'
import { isEqual, merge } from 'lodash-es'

type LayoutSettings = {
  header: HeaderProps
}

type LayoutSettingsContextType = {
  layoutSettings: LayoutSettings
  setLayoutSettings: (newLayoutSettings: LayoutSettings) => void
}

const DEFAULT_LAYOUT_SETTINGS: LayoutSettings = {
  header: {}
}

export const HeaderSettings: React.FC<HeaderProps> = ({ background, scrollBackground }) => {
  setLayoutSettings({ header: { background, scrollBackground } })

  return <></>
}

export const LayoutSettingsContext = React.createContext<LayoutSettingsContextType>({
  layoutSettings: DEFAULT_LAYOUT_SETTINGS,
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  setLayoutSettings: () => {}
})

export const LayoutSettingsContextProvider: React.FC = ({ children }) => {
  const [layoutSettings, setLayoutSettings] = useState(DEFAULT_LAYOUT_SETTINGS)

  return (
    <LayoutSettingsContext.Provider
      value={{
        layoutSettings,
        setLayoutSettings
      }}
    >
      {children}
    </LayoutSettingsContext.Provider>
  )
}

export const setLayoutSettings = (settings: PartialDeep<LayoutSettings>) => {
  const { layoutSettings, setLayoutSettings } = useContext(LayoutSettingsContext)

  // Ensure the settings are actually being changed before updating
  const mergedLayoutSettings = merge(
    {},
    DEFAULT_LAYOUT_SETTINGS,
    layoutSettings,
    settings
  )

  if (!isEqual(layoutSettings, mergedLayoutSettings)) {
    useEffect(() => {
      return setLayoutSettings(mergedLayoutSettings)
    }, [mergedLayoutSettings])
  }
}
