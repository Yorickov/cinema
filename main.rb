require 'rubygems'
require 'bundler/setup'

require_relative './lib/cinema_manager'

film, _err = CinemaManager['services'][:cinema].create_film('app', 120)
p film.name
