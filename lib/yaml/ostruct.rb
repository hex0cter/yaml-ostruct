require 'yaml/yaml_ostruct_impl'

# YamlOstruct module
module YamlOstruct
  attr_reader :config

  def self.new(args = {})
    YamlOstructImpl.new args
  end

  def self.clear
    @config = nil
  end

  class << self
    alias_method :delete_all, :clear
  end

  def self.method_missing(method_sym, *args)
    @config ||= YamlOstructImpl.new
    @config.send method_sym, *args
  end

  def self.load(dir)
    @config ||= YamlOstructImpl.new
    @config.load(dir)
  end

  def self.configure
    @config ||= YamlOstructImpl.new
    yield @config
  end
end
