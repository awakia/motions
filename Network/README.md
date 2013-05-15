# Network app

This sample app use afmotion.

## First Step

Type

```
bundle init
```

Then, Gemfile is generated.
Add 'afmition' gem

```Gemfile
gem 'afmotion'
```

And setup rakefile.

For bundler,

```Rakefile
require 'bundler'
Bundler.require  # thanks to this do not need to write "require 'bubble-wrap'"
```

For install AFNetwork cocoapods,

```Rakefile
Motion::Project::App.setup do |app|
  app.pods do
    pod 'AFNetworking'
  end
end
```

Then, try below in REPL.

```
AFMotion::HTTP.get("http://google.com") do |result|
  p result.body
end

AFMotion::JSON.get("http://jsonip.com") do |result|
  p result.object["ip"]
end
```
