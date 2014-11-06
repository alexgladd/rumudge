#!/usr/bin/env ruby

##
## main entry point for the game
##

require_relative 'lib/rumudge'

Log.a('Main', 'Starting RuMUDGE server...')

server = Rumudge::Server.new()

server.start
