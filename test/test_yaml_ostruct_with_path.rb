require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructWithPath < Minitest::Test
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

    YamlOstruct.delete(:attr)
    assert YamlOstruct.attr.nil?
  end

  def test_delete_all_attr
    YamlOstruct.clear
    assert YamlOstruct.attr.nil?

    YamlOstruct.attr1 = :foo
    assert YamlOstruct.attr1 == :foo

    YamlOstruct.attr2 = :bar
    assert YamlOstruct.attr2 == :bar

    YamlOstruct.delete_all
    assert YamlOstruct.attr1.nil?
    assert YamlOstruct.attr2.nil?
  end
end
