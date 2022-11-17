require 'image_processing/vips'
require 'image_processing/mini_magick'

class CoverImageUploader < Shrine
  include ImageUploader
  include PublicUploader

  DERIVATIVES = {
    magick: {
      tiny: ->(magick) {
        magick.resize_to_fill(840, 200).convert(:gif).call
      },
      tiny_webp: ->(magick) {
        magick.resize_to_fill(840, 200).convert(:webp).call
      },
      small: ->(magick) {
        magick.resize_to_fill(1680, 400).convert(:gif).call
      },
      small_webp: ->(magick) {
        magick.resize_to_fill(1680, 400).convert(:webp).call
      },
      large: ->(magick) {
        magick.resize_to_fill(3360, 800).convert(:gif).call
      },
      large_webp: ->(magick) {
        magick.resize_to_fill(3360, 800).convert(:webp).call
      }
    },
    vips: {
      tiny: ->(vips) {
        vips.resize_to_fill(840, 200).convert(:jpeg).saver(quality: 90, strip: true).call
      },
      small: ->(vips) {
        vips.resize_to_fill(1680, 400).convert(:jpeg).saver(quality: 75, strip: true).call
      },
      large: ->(vips) {
        vips.resize_to_fill(3360, 800).convert(:jpeg).saver(quality: 50, strip: true).call
      }
    }
  }.freeze

  Attacher.derivatives do |original|
    info = ImageInfo.new(original.path)
    if info.animated?
      magick = ImageProcessing::MiniMagick.source(original).loader(loader: info.type)
                                          .background('transparent').dispose('background')
      DERIVATIVES[:magick].transform_values { |proc| proc.call(magick) }
    else
      vips = ImageProcessing::Vips.source(original)
      DERIVATIVES[:vips].transform_values { |proc| proc.call(vips) }
    end
  end
end
