# Light

When you need all functionalities of ActiveRecord model but for other purposes than db transactions you can use Light. Light has additional `equality_state` and `to_h` method.

## Examples:

```ruby
require 'light'
class Person < Light::Model
  attributes :name, :email
end

person1 = Person.new(name: 'Pawel', email: 'pawel@o2.pl')
person1.to_h    # => {"name"=>"Pawel", "email"=>"pawel@o2.pl"}
person1.as_json # => {"name"=>"Pawel", "email"=>"pawel@o2.pl"}
person1.to_json # => "{\"name\":\"Pawel\",\"email\":\"pawel@o2.pl\"}"

person2 = Person.new('name' => 'Pawel', email: 'pawel@o2.pl')
person3 = Person.new(name: 'Sylwia', email: 'sylwia@o2.pl')

person1 == person2    # => true
person1 == person3    # => false
person1.eql?(person2) # => true 
person1.eql?(person3) # => false
```

## Installation

Add this line to your application's Gemfile:

    gem 'light'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install light

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
