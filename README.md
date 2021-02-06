# Ruby Blogger
[![Gem Version](https://badge.fury.io/rb/ruby_blogger.svg)](https://badge.fury.io/rb/ruby_blogger) ![Gem](https://img.shields.io/gem/dt/ruby_blogger?color=brightgreen)

### Introduction
Ruby Blogger is a simple exception tracker for all your `.rb` files. The command line tool makes it easy to read data on your raised exceptions. Read on to learn how to get started.

### Motivation
This gem was created with beginners in mind. We wanted to show how easy it is to collect data on what exceptions are being raised, when, how often and provide helpful information.

Ruby Blogger is easy to use and stores your data on your machine for convenience.

###  Dependencies
-- should we add this ?--
### Installation
At your command line, enter: 
```
gem install ruby_blogger
```

### Usage
#### To automatically track a file, add this on line 1:
```ruby
require 'ruby_blogger'
```
And work as you would normally. Each time an exception is raise, you'll get a confirmation that the logging was successful:
```
'Bug Logged Successfully:'
```
Followed by the actual exception trace.
#### To review all the exceptions logged so far, at your terminal, enter:
```
blog
```
#### To review all the exceptions logged for 1 file, at your terminal, enter:
```
blog filename.rb
```

### Contributing
Improvements and features are welcome as [pull requests](https://github.com/aumi9292/blogger/pulls).

Please open an [issue](https://github.com/aumi9292/blogger/issues) if needed before submitting a pull request.

Help us improve the data that `blog` returns! 

### Show your support
If this gem helped you, show your support by🌟it! 

### Authors Contact Information
[Austin Miller](https://github.com/aumi9292)
[Leena Lallmon](https://github.com/leena)
[Mandy Cheang](https://github.com/mandysGit)

### License
Copyright (c) 2021 [MIT license](https://github.com/aumi9292/blogger/blob/master/LICENSE.txt)

