require 'find'
require 'yaml'
require 'ostruct'
require 'hashugar'
require 'deep_merge'

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

    def load(dir, args = {})
      fail "Parameter #{File.join(Dir.pwd, dir)} is not a valid directory" unless File.directory? dir

      if args[:omit_path]
        load_omit_path(dir, @config, args)
      else
        load_recursively(dir, @config)
      end
    end

    def load_omit_path(dir, config, args)
      deep_merge = args.fetch :deep_merge, false
      fail "Parameter #{File.join(Dir.pwd, dir)} is not a valid directory" unless File.directory? dir

      Find.find(dir) do |yaml_file|
        next unless yaml_file =~ /.*\.yml$/ or yaml_file =~ /.*\.yaml$/
        new_config = YAML.load_file(yaml_file)

        attr_name = File.basename(yaml_file, File.extname(yaml_file)).to_sym
        if config.respond_to?(attr_name)
          old_config = config.send(attr_name).to_hash
          new_config = if deep_merge
                         new_config.deep_merge(old_config)
                       else
                         old_config.merge(new_config)
                       end
        end
        config.send("#{attr_name}=", new_config.to_hashugar)
      end
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
