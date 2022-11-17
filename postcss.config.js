const VAR_REGEX = /var\((--[a-z0-9-]+)\)/

/**
 * Custom PostCSS plugin to resolve custom properties within the same scope,
 * so that `color-mod` can be preprocessed without issues.
 */
const resolveLocalCustomProperties = (opts = {}) => {
  return {
    postcssPlugin: 'resolveLocalCustomProperties',
    Once(root) {
      root.walkDecls((decl) => {
        let customProperties = {}

        if (decl.value.match(VAR_REGEX)) {
          // Load the custom properties in the parent
          decl.parent.walkDecls((decl) => {
            if (!decl.variable) { return }

            customProperties[decl.prop] = decl.value
          })

          const transformedValue = decl.value.replace(
            VAR_REGEX,
            (match, variable) => {
              return customProperties[variable] ?? match
            }
          )

          decl.assign({ value: transformedValue })
        }
      })
    }
  }
}

module.exports = {
  plugins: [
    require('postcss-custom-media')({
      exportTo: './app/frontend/stylesheets/globals/breakpoints.json',
      importFrom: './app/frontend/stylesheets/globals/breakpoints.css'
    }),
    require('postcss-nesting'),
    require('autoprefixer'),
    require('postcss-easings'),
    require('postcss-preset-env'),
    require('postcss-custom-properties')({
      disableDeprecationNotice: true,
      importFrom: './app/frontend/stylesheets/globals/colors.css'
    }),
    resolveLocalCustomProperties,
    require('postcss-color-mod-function')
  ]
}
