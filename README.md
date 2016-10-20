# Vindinium::Client

## Introduction

This gem contains an easy-to-use client for the [Vindinium AI
Game](http://www.vindinium.org). It is not a starter package, i.e., it
contains no example bots. Instead, it is aimed at being the simplest possible
interface for any bot code.

## Usage

The entry point is the `Vindinium::Client` class, which is initialized with
your key. It offers two methods for either starting the training or entering
an arena match. These methods supply the current game state to a lambda block.
You must use the `#move direction` method in this loop, or your bot will
eventually be marked as "crashed".

So, in a nutshell:

    require 'vindinium_client'
    client = Vindinium::Client.new(key)

    client.start_training(turns: 42, map: 'm1') do |game|
      # ... thinking ...
      direction = my_ai.advise
      game.move! direction
    end

    client.start_arena_match do |map|
      # (see above)
    end

You will certainly need more information with regards to the API. Have a look
at the API documentation for that.

## License

This gem is licensed under the GNU GPLv3.

vindinium-client -- A client-side gem for the Vindinium game
Copyright (C) 2016  Eric MSP Veith <eveith+vindinium-client@veith-m.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
