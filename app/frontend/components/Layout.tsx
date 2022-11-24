import React from 'react'

const Layout: React.FC = ({ children }) => {
  return (
    <>
      {children}
    </>
  )
}

export default (page: React.ReactNode) => <Layout>{page}</Layout>
