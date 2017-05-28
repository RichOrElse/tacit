# Tacit

Collection of ruby refinements to reduce lines of code. Includes refinements with glue methods for inheritance chaining.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tacit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tacit

## Usage

```ruby
require 'tacit'

using Tacit

# Given modules
Eats = Module.new
Sleeps = Module.new
Domesticated = Module.new
Owned = Module.new
Barks = Module.new
Runs = Module.new
Lazy = Module.new
Fat = Module.new

# With operator (<<) returns new Module or Class with the next prepending the previous
Animal = Class.new << Eats << Sleeps
Animal.ancestors        # => Sleeps, Eats, Animal, ...

# Overlays operator (>>) returns new Module or Class with the previous prepending over the next
Pet = Domesticated >> Owned >> Animal
Pet.ancestors           # => Domesticated, Owned, Pet, Sleeps, Eats, Animal, ...

# Combines operator (*) returns new extended Module or Class
Dog = Pet * Barks * Runs
Dog.ancestors           # => Dog, Runs, Barks, Domesticated, Owned, Pet, ...

# as base class operator (+@), returns a new class inheriting from the Module or Class
Cat = +Pet
Cat.ancestors           # => Cat, Domesticated, Owned, Pet, ...

# As operator (+) returns a new extended Module or Class with the ancestors in the same particular order
Garfield = Fat + Lazy + Cat
Garfield.ancestors      # => Garfield, Fat, Lazy, Cat, ...
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tacit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
