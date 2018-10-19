require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructWithInvalidFile < Minitest::Test
  def setup
    YamlOstruct.clear
    YamlOstruct.configure do |configure|
      configure.skip_error = true
    end

    YamlOstruct.load('config-invalid')
  end

  def test_invalid
    assert YamlOstruct.fox.color.is.brown
    assert YamlOstruct.fox.color.is.grey.nil?
    assert YamlOstruct.rabbit.nil?
  end
end
