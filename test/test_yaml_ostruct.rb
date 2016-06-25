require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstruct < Minitest::Test
  def setup
    YamlOstruct.clear
    YamlOstruct.load('config')
  end

  def test_fox
    assert YamlOstruct.fox.color.is.brown
    assert YamlOstruct.fox.color.is.grey.nil?
  end

  def test_people
    assert YamlOstruct.asia.china.people.language == 'chinese'
    assert YamlOstruct.asia.people.language == 'english'
  end

  def test_dynamic_attr
    YamlOstruct.clear
    assert YamlOstruct.attr.nil?

    YamlOstruct.attr = :foo
    assert YamlOstruct.attr == :foo
  end
end
