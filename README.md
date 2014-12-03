# RuMUDGE

*Pronounced like "rummage"*

A Ruby MUD Game Engine

## Usage

Getting up and running with RuMUDGE is as simple as implementing a Rumudge::Controller subclass.

```ruby
# use rumudge
require 'rumudge'

# define a controller subclass
class MyController < Rumudge::Controller
  # use rails-style callbacks to setup command handling
  permitted_commands :hello, :quit

  private

  # called to handle the 'hello' command
  def hello
    self.response = "Hello to you, too!\n"
  end

  # called to handle the 'quit' command
  def quit
    self.response = "Goodbye!\n"

    # call finish to signal that the controller should terminate
    finish
  end
end

# setup the environment to use your controller
Rumudge.environment.startup_ctrl = MyController

# instantiate and start a server
server = Rumudge::Server.new
server.start
```

For a more complete example, see the [test controller](test/test_controller.rb)

## License

Copyright 2014 Alex Gladd

RuMUDGE is licensed under the LGPLv3

![LGPL3 Logo](http://www.gnu.org/graphics/lgplv3-88x31.png)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
