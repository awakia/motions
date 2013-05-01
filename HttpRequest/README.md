# HttpResuest Sample App

## Instructions

The bundler site says,

```
$ bundle
$ rake
```

is enough to use gems, but it's not.
We must install each gems before type 'bundle install'

```
$ bundle
Resolving dependencies...
Your Gemfile has no gem server sources. If you need gems that are not already on your machine, add a line like this to your Gemfile:
source 'https://rubygems.org'
Could not find gem 'bubble-wrap (~> 1.2.0) ruby' in the gems available on this machine.
```

```
$ gem install bubble-wrap
Fetching: bubble-wrap-1.2.0.gem (100%)
Successfully installed bubble-wrap-1.2.0
1 gem installed
$ bundle
Resolving dependencies...
Using bubble-wrap (1.2.0)
Using bundler (1.3.5)
Your bundle is complete!
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

## References

### RubyMotion Tutorial of HTTP Request

- http://rubymotion-tutorial.com/9-http/

This tutorial introduce BubbleWrap instead of NSURLConnection.

### BubbleWrap.io

- http://bubblewrap.io/

Main site of bubble-wrap gem

### Bundler for Ruby motion

- http://gembundler.com/v1.3/rubymotion.html

This document teach us how to use gems for ruby motion.
