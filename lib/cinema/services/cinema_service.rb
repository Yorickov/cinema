require_relative './application_service'
require_relative '../entities/cinema_hall'
require_relative '../entities/film'
require_relative '../entities/film_screening'

class CinemaService < ApplicationService
  def create_cinema_hall(name, rows, cols)
    cinema_hall = CinemaHall.new(name, rows, cols)
    errors = cinema_hall.validate!
    cinema_hall_repository.save(cinema_hall) unless errors

    [cinema_hall, errors]
  end

  def create_film(name, duration)
    film = Film.new(name, duration)
    errors = film.validate!
    film_repository.save(film) unless errors

    [film, errors]
  end

  def create_film_screening(film_id, cinema_hall_id, time)
    film = film_repository.find(film_id)
    hall = cinema_hall_repository.find(cinema_hall_id)
    film_screening = FilmScreening.new(film, hall, time)
    errors = film_screening.validate!
    film_screening_repository.save(film_screening) unless errors

    [film_screening, errors]
  end
end
