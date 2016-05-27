require 'find'
require 'yaml'
require 'ostruct'
require 'hashugar'

module YamlOstruct
  # YamlOstructImpl class
  class YamlOstructImpl
    attr_reader :config
    extend Gem::Deprecate

    def initialize
      @config = OpenStruct.new
    end

    def method_missing(method_sym, *args)
      if @config.respond_to? method_sym
        @config.send method_sym, *args
      elsif method_sym.to_s.end_with?('=')
        @config.send method_sym, *args
      elsif method_sym == :clear
        @config = OpenStruct.new
      else
        nil
      end
    end

    def load(dir)
      fail "Parameter #{File.join(Dir.pwd, dir)} is not a valid directory" unless File.directory? dir
      load_recursively(dir, @config)
    end

    def load_recursively(dir, config)
      files = Dir.entries(dir)
      files.each do |file_name|
        next if file_name.start_with?('.')
        if File.directory?("#{dir}/#{file_name}")
          new_config = OpenStruct.new
          config.send("#{file_name}=", load_recursively("#{dir}/#{file_name}", new_config))
        end

        extension = File.extname(file_name)
        next unless extension == '.yml' or extension == '.yaml'
        new_config = YAML.load_file("#{dir}/#{file_name}")
        config.send("#{File.basename(file_name, extension)}=", new_config.to_hashugar)
      end
      config
    end
  end
end
