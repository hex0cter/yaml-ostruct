require_relative 'paths'
require 'yaml/ostruct'
require 'minitest/autorun'

class TestYamlOstructWithoutPath < Minitest::Test
  def setup
    YamlOstruct.clear
    YamlOstruct.configure do |configure|
      configure.omit_path = true
    end

    YamlOstruct.load('config')
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
    assert YamlOstruct.bob.nil?

    YamlOstruct.bob = :foo
    assert YamlOstruct.bob == :foo

    YamlOstruct.bob = :bar
    assert YamlOstruct.bob == :bar
  end

  def test_overwriting
    YamlOstruct.configure do |configure|
      configure.deep_merge = false
    end

    YamlOstruct.load('config/overwritting/animal')
    YamlOstruct.load('config/overwritting/bird')

    assert YamlOstruct.setting.type == 'bird'
    assert YamlOstruct.setting.list == %w(seagull pigeon)
  end

  def test_merging
    YamlOstruct.configure do |configure|
      configure.deep_merge = true
    end

    YamlOstruct.load('config/overwritting/animal')
    YamlOstruct.load('config/overwritting/bird')

    assert YamlOstruct.setting.type == 'bird'
    assert YamlOstruct.setting.list == %w(seagull pigeon monkey sheep)
  end
end
