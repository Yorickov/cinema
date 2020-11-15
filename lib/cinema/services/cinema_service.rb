require_relative './application_service'
require_relative '../entities/cinema_hall'
require_relative '../entities/film'
require_relative '../entities/film_screening'

class CinemaService < ApplicationService
  def create_cinema_hall(name, rows, cols)
    cinema_hall = CinemaHall.new(name, rows, cols)
    cinema_hall_repository.save(cinema_hall)
    cinema_hall
  end

  def create_film(name, duration)
    film = Film.new(name, duration)
    film_repository.save(film)
    film
  end

  def create_film_screening(film_id, cinema_hall_id, time)
    film = film_repository.find(film_id)
    hall = cinema_hall_repository.find(cinema_hall_id)
    film_screening = FilmScreening.new(film, hall, time)
    film_screening_repository.save(film_screening)
    film_screening
  end
end
