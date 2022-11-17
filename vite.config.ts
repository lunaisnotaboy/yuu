import ReactPlugin from '@vitejs/plugin-react'
import { defineConfig, Plugin } from 'vite'
import GZipPlugin from 'rollup-plugin-gzip'
import { brotliCompressSync } from 'zlib'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  build: {
    cssCodeSplit: true,
    sourcemap: process.env.RAILS_ENV !== 'production'
  },
  clearScreen: false,
  define: {
    _DEV_: process.env.RAILS_ENV !== 'production'
  },
  plugins: [
    (GZipPlugin() as Plugin),
    (GZipPlugin({
      customCompression: (content) => brotliCompressSync(Buffer.from(content)),
      fileName: '.br'
    }) as Plugin),
    ReactPlugin(),
    RubyPlugin()
  ],
  resolve: {
    alias: {
      '@/': `${__dirname}/app/frontend/`
    }
  }
})
