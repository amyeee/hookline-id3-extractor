require 'erb'

class PlistGenerator
  def self.generate
    template_path = File.join(APP_ROOT, 'config', 'tv.hookline.id3-extractor.plist.erb')
    template      = File.read(template_path)

    ruby_path         = `which ruby`.chomp
    working_directory = APP_ROOT

    output = ERB.new(template).result(binding)
    return output
  end
end
