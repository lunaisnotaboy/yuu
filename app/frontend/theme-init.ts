const themeKey = 'theme'

const getPreferredTheme = (): string => {
  const storedTheme = localStorage.getItem(themeKey)

  return storedTheme ??
    window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light'
}

export const setTheme = () => {
  const body = document.querySelector(':root')

  body?.setAttribute(`data-${themeKey}`, getPreferredTheme())
}
