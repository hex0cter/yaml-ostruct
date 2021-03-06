require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructInstanceWithPath < Minitest::Test
  def test_fox
    yaml_ostruct = YamlOstruct.new
    yaml_ostruct.load('config')
    assert yaml_ostruct.fox.color.is.brown
    assert yaml_ostruct.fox.color.is.grey.nil?
  end

  def test_people
    yaml_ostruct = YamlOstruct.new
    yaml_ostruct.load('config')
    assert yaml_ostruct.asia.people.language == 'english'
    assert yaml_ostruct.asia.china.people.language == 'chinese'
  end

  def test_dynamic_attr
    yaml_ostruct = YamlOstruct.new
    assert yaml_ostruct.attr.nil?

    yaml_ostruct.attr = :foo
    assert yaml_ostruct.attr == :foo

    yaml_ostruct.delete(:attr)
    assert yaml_ostruct.attr.nil?
  end

  def test_delete_all_attr
    yaml_ostruct = YamlOstruct.new
    assert yaml_ostruct.attr1.nil?
    assert yaml_ostruct.attr2.nil?

    yaml_ostruct.attr1 = :foo
    assert yaml_ostruct.attr1 == :foo

    yaml_ostruct.attr2 = :bar
    assert yaml_ostruct.attr2 == :bar

    yaml_ostruct.delete_all
    assert yaml_ostruct.attr1.nil?
    assert yaml_ostruct.attr2.nil?
  end

  def test_multiple_instances
    animal_config = YamlOstruct.new
    bird_config = YamlOstruct.new
    animal_config.from = :land
    bird_config.from = :sky

    assert animal_config.from == :land
    assert bird_config.from == :sky
  end
end
