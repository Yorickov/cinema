require_relative './application_service'

class CinemaService < ApplicationService
  def create_cinema_hall(name, rows, cols)
    cinema_hall = entities[:cinema_hall].new(name, rows, cols)
    errors = cinema_hall.validate!
    repositories[:cinema_hall].save(cinema_hall) unless errors

    [cinema_hall, errors]
  end

  def create_film(name, duration)
    film = entities[:film].new(name, duration)
    errors = film.validate!
    repositories[:film].save(film) unless errors

    [film, errors]
  end

  def create_film_screening(film_id, cinema_hall_id, time)
    film = repositories[:film].find(film_id)
    hall = repositories[:cinema_hall].find(cinema_hall_id)
    film_screening = entities[:film_screening].new(film, hall, time)
    errors = film_screening.validate!
    repositories[:film_screening].save(film_screening) unless errors

    [film_screening, errors]
  end
end
