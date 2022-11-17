import { useMediaQuery } from '@react-hookz/web/esnext'

export function useReducedMotion() {
  return useMediaQuery('(prefers-reduced-motion: reduce)')
}
