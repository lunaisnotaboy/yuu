import { useLocation } from 'react-router-dom'

export function useQueryParams(): URLSearchParams {
  return new URLSearchParams(useLocation().search)
}
