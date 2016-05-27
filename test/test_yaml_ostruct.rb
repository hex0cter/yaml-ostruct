require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstruct < Minitest::Test
  def setup
    YamlOstruct.load('config')
  end

  def test_fox
    assert YamlOstruct.fox.color.is.brown
    assert YamlOstruct.fox.color.is.grey.nil?
  end

  def test_people
    assert YamlOstruct.asia.china.people.language == 'chinese'
    assert YamlOstruct.people.language == 'english'
  end

  def test_consumer
    assert YamlOstruct.consumer.language == 'english'
    assert YamlOstruct.consumer.hobbies.balls == 'tennis'
  end

  def test_dynamic_attr
    YamlOstruct.clear
    assert YamlOstruct.attr.nil?

    YamlOstruct.attr = :foo
    assert YamlOstruct.attr == :foo

    YamlOstruct.set(:attr, :bar)
    assert YamlOstruct.attr == :bar
  end
end
