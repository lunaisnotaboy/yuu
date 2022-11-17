import React, { ComponentProps, useContext } from 'react'
import { IsModalContext } from '@/contexts/ModalContext'
import { useQueryParams } from '@/hooks/useQueryParams'
import { Link, useLocation } from 'react-router-dom'
import type { Location } from 'history'

function useBackgroundLocation(): Location | undefined {
  const isModal = useContext(IsModalContext)
  const location = useLocation() as Location & {
    state?: { background?: Location }
  }

  const { background } = location.state ?? {}

  if (isModal) { return background }

  return background ?? location
}

const ModalLink: React.FC<{
  component?: React.ElementType
} & ComponentProps<typeof Link>> = ({ component: Component = Link, to, ...args }) => {
  const background = useBackgroundLocation()
  const query = useQueryParams()
  const returnTo = background?.pathname ?? query.get('returnTo')

  if (typeof to === 'string') {
    // When we get a string, we need to parse it to add our `returnTo` query param
    const url = new URL(to, window.location.href)
    const search = new URLSearchParams(url.search)

    if (returnTo) { search.append('returnTo', returnTo) }

    to = {
      pathname: to,
      search: search.toString()
    }
  } else {
    const search = new URLSearchParams(to.search)

    if (returnTo) { search.append('returnTo', returnTo) }

    to = {
      ...to,
      search: search.toString()
    }
  }

  return <Component state={{ background }} to={to} {...args} />
}

export default ModalLink
