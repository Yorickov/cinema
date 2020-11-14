# require 'rubygems'
# require 'bundler/setup'

require_relative 'lib/cinema_manager'

film_screening = CinemaManager.create_film_screening('the appartment', 120, 'hall 1', 30, 50, Time.new)
puts film_screening.film.name
