import breakpoints from '@/stylesheets/globals/breakpoints.json'
import { useMediaQuery } from '@react-hookz/web/esm'

export function useBreakpoint(breakpoint: keyof typeof breakpoints['custom-media']) {
  return useMediaQuery(breakpoints['custom-media'][breakpoint])
}
