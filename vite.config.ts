import { defineConfig, Plugin, splitVendorChunkPlugin as SplitVendorChunkPlugin } from 'vite'
import ReactPlugin from '@vitejs/plugin-react'
import GZipPlugin from 'rollup-plugin-gzip'
import { brotliCompressSync } from 'zlib'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig(({ mode }) => ({
  build: {
    cssCodeSplit: true,
    sourcemap: mode !== 'production'
  },
  clearScreen: false,
  define: {
    _DEV_: mode !== 'production'
  },
  plugins: [
    (GZipPlugin() as Plugin),
    (GZipPlugin({
      customCompression: (content) => brotliCompressSync(Buffer.from(content)),
      fileName: '.br'
    }) as Plugin),
    ReactPlugin(),
    RubyPlugin(),
    SplitVendorChunkPlugin()
  ],
  resolve: {
    alias: {
      '@/': `${__dirname}/app/frontend/`
    }
  }
}))
