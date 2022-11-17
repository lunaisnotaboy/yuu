import { ReactComponent as SearchIcon } from '@/images/icons/search.svg'
import { ReactComponent as Logo } from '@/images/logo.svg'
import { FormattedMessage, useIntl } from 'react-intl'
import React, { Suspense, useState } from 'react'
import ModalLink from '@/components/ModalLink'
import { useIntersection } from 'react-use'
import { NavLink } from 'react-router-dom'
import Spinner from '@/components/Spinner'
import styles from './styles.module.css'
import { uniqueId } from 'lodash-es'

export type HeaderBackground = 'opaque' | 'transparent'
export type HeaderProps = {
  background?: HeaderBackground
  scrollBackground?: HeaderBackground
}

const Header = ({ background = 'opaque', scrollBackground = 'opaque' }: HeaderProps) => {
  // We don't expect to have this multiple times per page, but we should
  // still be careful
  const [searchId] = useState(() => uniqueId('header-search-'))
  // const { session } = useSession()
  const intersectionRef = React.useRef(null)
  const intersection = useIntersection(intersectionRef, { threshold: 0 })
  const isScrolled = !intersection?.isIntersecting
  const displayBackground = isScrolled ? scrollBackground : background
  const { formatMessage } = useIntl()

  return (
    <>
      <div ref={intersectionRef} className={styles.headerScrollMonitor}></div>
      <header className={[styles.header, styles[displayBackground]].join(' ')}>
        <nav
          className={[
            // utilStyles.container,
            // session ? styles.loggedIn : null,
            styles.container
          ].join(' ')}
        ></nav>
      </header>
    </>
  )
}

export default Header
