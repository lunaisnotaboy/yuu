import { useAsync, useCookie, useEvent } from 'react-use'
import { Locale as DateFnsLocale } from 'date-fns'
import type { OnErrorFn } from '@formatjs/intl'
import preferredLocale from 'preferred-locale'
import { IntlProvider } from 'react-intl'
import React, { useReducer } from 'react'
import translations from '@/locales'

type LocaleState = {
  locale: string
  setLocale: (locale: string) => void
  unsetLocale: () => void
}

const IntlContext: React.FC<{ locale?: string }> = ({ children, locale }) => {
  const value = useLocaleState(locale)
  const { value: localeData } = useAsync(translations[value.locale].load)
  const onError: OnErrorFn | undefined = _DEV_
    ? err => {
      if (err.code === 'MISSING_TRANSLATION') { return }

      throw err
    }
    : undefined

  return localeData ? (
    <LocaleContext.Provider value={value}>
      <DateFnsLocaleContext.Provider value={localeData.dateFns}>
        <IntlProvider
          defaultRichTextElements={{
            b: (children) => <b>{children}</b>
          }}
          key={value.locale}
          locale={value.locale}
          messages={localeData.kitsu}
          onError={onError}
        >
          {children}
        </IntlProvider>
      </DateFnsLocaleContext.Provider>
    </LocaleContext.Provider>
  ) : null
}

function useLocaleState(locale?: string): LocaleState {
  const availableLocales = Object.keys(translations)
  const [cookie, setCookie, unsetCookie] = useCookie('chosenLocale')
  const [_, forceUpdate] = useReducer(x => x + 1, 0)

  if (locale) {
    return { locale, setLocale: setCookie, unsetLocale: unsetCookie }
  } else if (cookie) {
    // Listen for language change
    useEvent('languagechange', forceUpdate, window)

    // If the user has chosen an invalid locale, delete it
    if (cookie && availableLocales.indexOf(cookie) === -1) {
      unsetCookie()
    }

    return { locale: cookie, setLocale: setCookie, unsetLocale: unsetCookie }
  } else {
    const availableLocales = Object.keys(translations)

    return {
      locale: preferredLocale(availableLocales, 'en'),
      setLocale: setCookie,
      unsetLocale: unsetCookie
    }
  }
}

// @ts-ignore We guarantee that this is actually never null
export const DateFnsLocaleContext = React.createContext<DateFnsLocale>(null)

export const LocaleContext = React.createContext<{
  locale: string
  setLocale: (locale: string) => void
  unsetLocale: () => void
}>({
  locale: 'en',
  setLocale: () => null,
  unsetLocale: () => null
})

export function useDateFnsLocale(): DateFnsLocale {
  return React.useContext(DateFnsLocaleContext)
}

export function useLocale(): LocaleState {
  return React.useContext(LocaleContext)
}
