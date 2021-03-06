$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'yaml-ostruct'
  s.version     = YamlOstruct::VERSION
  s.summary     = 'Read yaml files with path into an OpenStruct'
  s.description = 'Read yaml files recursively from a given directory and return an OpenStruct retaining the path'
  s.authors     = ['Daniel Han']
  s.email       = 'hex0cter@gmail.com'
  s.homepage    = 'https://github.com/hex0cter/yaml-ostruct'
  s.license     = 'MIT'
  s.files         = Dir['lib/**/*']
  s.required_ruby_version = '>= 2.0.0'
  s.require_paths = ['lib']

  s.add_dependency 'hashugar', '~> 1.0'
  s.add_dependency 'deep_merge', '~> 1.0'
end
