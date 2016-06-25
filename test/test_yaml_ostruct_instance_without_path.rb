require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructInstanceWithoutPath < Minitest::Test
  def test_fox
    yaml_sugar = YamlOstruct.new(omit_path: true)
    yaml_sugar.load('config')
    assert yaml_sugar.fox.color.is.brown
    assert yaml_sugar.fox.color.is.grey.nil?
  end

  def test_people
    yaml_sugar = YamlOstruct.new(omit_path: true)
    yaml_sugar.load('config')
    assert yaml_sugar.people.language == 'english'
  end

  def test_consumer
    yaml_sugar = YamlOstruct.new(omit_path: true)
    yaml_sugar.load('config')
    assert yaml_sugar.consumer.language == 'english'
    assert yaml_sugar.consumer.hobbies.balls == 'tennis'
  end

  def test_dynamic_attr
    yaml_sugar = YamlOstruct.new(omit_path: true)
    assert yaml_sugar.attr.nil?

    yaml_sugar.attr = :foo
    assert yaml_sugar.attr == :foo

    yaml_sugar.attr = :bar
    assert yaml_sugar.attr == :bar

    yaml_sugar.clear
    assert yaml_sugar.attr.nil?
  end

  def test_overwriting
    yaml_sugar = YamlOstruct.new(omit_path: true)
    yaml_sugar.load('config')
    yaml_sugar.load('config/overwritting/animal')
    yaml_sugar.load('config/overwritting/bird')

    assert yaml_sugar.setting.type == 'bird'
    assert yaml_sugar.setting.list == %w(seagull pigeon)
  end

  def test_merging
    yaml_sugar = YamlOstruct.new(omit_path: true, deep_merge: true)
    yaml_sugar.load('config')
    yaml_sugar.load('config/overwritting/animal')
    yaml_sugar.load('config/overwritting/bird')

    assert yaml_sugar.setting.type == 'bird'
    assert yaml_sugar.setting.list == %w(seagull pigeon monkey sheep)
  end

  def test_multiple_instances
    animal_config = YamlOstruct.new(omit_path: true)
    bird_config = YamlOstruct.new(omit_path: true)
    animal_config.load('config/overwritting/animal')
    bird_config.load('config/overwritting/bird')
    animal_config.from = :land
    bird_config.from = :sky

    assert animal_config.setting.type == 'animal'
    assert bird_config.setting.type == 'bird'

    assert animal_config.setting.list == %w(monkey sheep)
    assert bird_config.setting.list == %w(seagull pigeon)

    assert animal_config.from == :land
    assert bird_config.from == :sky
  end
end
