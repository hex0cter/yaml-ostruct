# The yaml-ostruct gem for Ruby

yaml-ostruct is a ruby gem inspired by hashugar. It reads all the yaml files from
a given directory, and build them into an OpenStruct. If there are several yaml
files with the same name, the later will be merged into the earlier.

The major difference between yaml-ostruct and its twin sister gem yaml-ostruct is that,
yaml-ostruct takes the path of the yaml file into part of its structure, but yaml-ostruct
ignore the directory structure and only focus on the yaml file itself.

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
    language: english
```

In your project,

```ruby
  YamlOstruct.load('config')

  assert YamlOstruct.fox.color.is.brown
  assert YamlOstruct.asia.china.people.language == 'chinese'
  assert YamlOstruct.asia.people.language == 'english'
```

You can also add a dynamic attribute on the fly like this:

```ruby
  YamlOstruct.attr = :foo
  assert YamlOstruct.attr == :foo
```

If you wanna clear all the previous settings, just call

```ruby
  YamlOstruct.clear
```

Sometimes you might want to have multiple instances of YamlOstruct, which are independent
of each other. In that case you can just use the following syntax:

```ruby
    config = YamlOstruct.new
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
