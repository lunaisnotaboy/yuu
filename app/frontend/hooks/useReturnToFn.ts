import { useLocation, useNavigate } from 'react-router-dom'
import { useQueryParams } from './useQueryParams'
import { useCallback } from 'react'

export function useReturnToFn(defaultLocation?: string): () => void {
  const location = useLocation() as { state: { background?: Location } }
  const navigate = useNavigate()
  const params = useQueryParams()
  const returnTo = params.get('returnTo')

  return useCallback(() => {
    if (location.state.background) {
      navigate(location.state.background)
    } else if (returnTo) {
      navigate(returnTo)
    } else if (defaultLocation) {
      navigate(defaultLocation)
    }
  }, [returnTo, location.state.background])
}
