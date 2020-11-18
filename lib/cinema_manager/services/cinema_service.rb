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
end
