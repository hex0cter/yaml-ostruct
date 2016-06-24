require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructWithoutPath < Minitest::Test
  def setup
    YamlOstruct.load('config', omit_path: true)
  end

  def test_fox
    assert YamlOstruct.fox.color.is.brown
    assert YamlOstruct.fox.color.is.grey.nil?
  end

  def test_people
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

    YamlOstruct.attr = :bar
    assert YamlOstruct.attr == :bar
  end

  def test_overwriting
    YamlOstruct.load('config/overwritting/animal')
    YamlOstruct.load('config/overwritting/bird')

    assert YamlOstruct.setting.type == 'bird'
    assert YamlOstruct.setting.list == %w(seagull pigeon)
  end

  def test_merging
    YamlOstruct.load('config/overwritting/animal', omit_path: true)
    YamlOstruct.load('config/overwritting/bird', omit_path: true, deep_merge: true)

    assert YamlOstruct.setting.type == 'bird'
    assert YamlOstruct.setting.list == %w(seagull pigeon monkey sheep)
  end
end
