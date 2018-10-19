require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructInstanceWithInvalidFile < Minitest::Test
  def test_fox
    yaml_ostruct = YamlOstruct.new(skip_error: true)
    yaml_ostruct.load('config-invalid')

    assert yaml_ostruct.fox.color.is.brown
    assert yaml_ostruct.fox.color.is.grey.nil?
    assert yaml_ostruct.rabbit.nil?
  end
end
