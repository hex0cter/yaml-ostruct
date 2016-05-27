require 'yaml/yaml_ostruct_impl'

# YamlSugar module
module YamlOstruct
  attr_reader :config

  def self.new
    YamlOstructImpl.new
  end

  def self.clear
    @config = nil
  end

  def self.method_missing(method_sym, *args)
    @config ||= YamlOstructImpl.new
    @config.send method_sym, *args
  end

  def self.load(dir)
    @config ||= YamlOstructImpl.new
    @config.load(dir)
  end
end
