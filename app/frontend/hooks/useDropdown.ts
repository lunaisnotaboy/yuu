import { Options } from '@popperjs/core'
import { useClickAway } from 'react-use'
import { usePopper } from 'react-popper'
import { useState } from 'react'

export function useDropdown(config: Partial<Options>) {
  const [arrowElement, setArrowElement] = useState<HTMLElement | null>(null)
  const [isOpen, setIsOpen] = useState(false)
  const [menuElement, setMenuElement] = useState<HTMLElement | null>(null)
  const [toggleElement, setToggleElement] = useState<HTMLElement | null>(null)

  useClickAway({ current: menuElement }, () => isOpen && setIsOpen(false), [
    'click'
  ])

  const popper = usePopper(toggleElement, menuElement, {
    modifiers: [
      { name: 'arrow', options: { element: arrowElement } },
      {
        name: 'preventOverflow',
        options: {
          altAxis: true,
          padding: 10
        }
      },
      ...(config.modifiers || [])
    ],
    ...config
  })

  const visibility: 'visible' | 'hidden' = isOpen ? 'visible' : 'hidden'

  return {
    isOpen,
    setIsOpen,
    toggleProps: {
      ref: setToggleElement,
      onClick: () => setIsOpen(!isOpen)
    },
    arrowProps: { ref: setArrowElement, style: popper.styles.arrow },
    menuProps: {
      ref: setMenuElement,
      role: 'menu',
      style: {
        visibility,
        ...popper.styles.popper
      },
      ...popper.attributes.popper
    },
    itemProps: { role: 'menuitem' }
  }
}
