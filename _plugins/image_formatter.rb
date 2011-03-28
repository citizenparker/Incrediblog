require 'mini_magick'
require 'fileutils'

module Jekyll
  class ImageFormatter < Generator
    safe true
    priority :low

    def generate(site)
      Dir.glob('_images/*').each do |file|
        convert_image(file, new_path(file, site.config['destination'])) unless File.directory?(file)
      end
    end

    private

    def convert_image(old_file, new_file)
      image = MiniMagick::Image.open(old_file)
      result = image.composite(MiniMagick::Image.open(stamp_path)) do |c|
        c.gravity "southeast"
      end
      result.write new_file
    end

    def new_path(old_file, destination_root)
      base_path = File.join(destination_root, 'images')
      FileUtils.mkdir_p(base_path) unless Dir.exists?(base_path)
      File.join(base_path, File.basename(old_file))
    end

    def stamp_path
      File.join(Dir.pwd, '_images/support', 'stamp.png')
    end
  end
end
