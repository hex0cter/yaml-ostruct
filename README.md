# The yaml-ostruct gem for Ruby

[![Gem Version](https://badge.fury.io/rb/yaml-ostruct.svg)](https://badge.fury.io/rb/yaml-ostruct)
[![Build Status](https://travis-ci.org/hex0cter/yaml-ostruct.svg?branch=master)](https://travis-ci.org/hex0cter/yaml-ostruct)
[![Coverage Status](https://coveralls.io/repos/github/hex0cter/yaml-ostruct/badge.svg?branch=master)](https://coveralls.io/github/hex0cter/yaml-ostruct?branch=master)

Previously known as yaml-sugar, yaml-ostruct is a ruby gem inspired by hashugar. It
reads all the yaml files from a given directory, and build them into an OpenStruct.

The gem works in two modes, omitting the directories in which the yaml files are located,
or having it as part of the structure. By default the later is used. If you want to
omit the directories, use option omit_path: true in the configure method. In that case,
files with the same name but located in different directories will be merged.

## How to use?

In your ruby code,

```ruby
  require 'yaml/ostruct'
  YamlOstruct.load(dir)
```

then you are ready to go.

For example, if you have the following files inside your config directory:

```
.
+-- config
       +-- fox.yaml
       +-- asia
             +-- china
             |     +-----people.yaml
             +-- people.yaml

```

config/fox.yaml
```yaml
  color:
    is:
      green: true
```

config/asia/china/people.yaml

```yaml
    language: chinese
```

config/asia/people.yaml

```yaml
    language: english
```

By default, parent directories of the yaml file are used as part of the structure.
For example,

```ruby
  YamlOstruct.load('config')

  assert YamlOstruct.fox.color.is.brown
  assert YamlOstruct.asia.china.people.language == 'chinese'
  assert YamlOstruct.asia.people.language == 'english'
```

However if you want to omit the directories,

```ruby
  YamlOstruct.configure do |configure|
    configure.omit_path = true
  end

  YamlOstruct.load('config')

  assert YamlOstruct.fox.color.is.brown
  assert YamlOstruct.people.language == 'english'
```

In this case if there are multiple files with the same name found in different
directories, they will be merged before the conversion. You can specify

```ruby
  YamlOstruct.configure do |configure|
    configure.omit_path = true
    configure.deep_merge = true
  end

```

for a deep merge.

To skip the errors in parsing the yaml files, you can use
```ruby
  YamlOstruct.configure do |configure|
    configure.skip_error = true
  end
```
You can also add a dynamic attribute on the fly like this:

```ruby
  YamlOstruct.attr = :foo
  assert YamlOstruct.attr == :foo
```

If you wanna remove an attribute, you can call

```ruby
  YamlOstruct.delete(:attr)
```

If you wanna clear all the previous settings, just call

```ruby
  YamlOstruct.clear
```

Or
```ruby
  YamlOstruct.delete_all
```

Sometimes you might want to have multiple instances of YamlOstruct, which are independent
of each other. In that case you can just use the following syntax:

```ruby
    config = YamlOstruct.new # Or YamlOstruct.new(omit_path: true, deep_merge: true, skip_error: true)
    config.load('config')

    config.attr = :land
    assert config.attr == :land
```

## How to install?

From a terminal run

```bash
  gem install yaml-ostruct
```

or add the following code into your Gemfiles:

```ruby
  gem 'yaml-ostruct'
```

## How to build/install from source?

```bash
  gem build yaml-ostruct.gemspec
  gem install yaml-ostruct-<VERSION>.gem
```

## How to run the test?

```bash
  rake test
```

## License

This code is free to use under the terms of the MIT license.

## Contribution

You are more than welcome to raise any issues [here](https://github.com/hex0cter/yaml-ostruct/issues), or create a Pull Request.
