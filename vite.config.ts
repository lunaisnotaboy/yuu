import { defineConfig, Plugin, splitVendorChunkPlugin as SplitVendorChunkPlugin } from 'vite'
import ReactPlugin from '@vitejs/plugin-react'
import GZipPlugin from 'rollup-plugin-gzip'
import { brotliCompressSync } from 'zlib'
import RubyPlugin from 'vite-plugin-ruby'
import SVGRPlugin from 'vite-plugin-svgr'

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
    RubyPlugin(),
    SplitVendorChunkPlugin(),
    SVGRPlugin()
  ],
  resolve: {
    alias: {
      '@/': `${__dirname}/app/frontend/`
    }
  }
})
