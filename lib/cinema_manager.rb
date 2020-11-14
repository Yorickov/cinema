require_relative 'entities/cinema_hall'
require_relative 'entities/film'
require_relative 'entities/film_screening'

class CinemaManager
  def self.create_film_screening(film_name, duration, cinema_hall_name, rows, cols, time)
    film = Film.new(film_name, duration)
    cinema_hall = CinemaHall.new(cinema_hall_name, rows, cols)
    FilmScreening.new(film, cinema_hall, time)
  end
end
