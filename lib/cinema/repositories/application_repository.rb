# require_relative '../repositories/cinema_hall_repository'
# require_relative '../repositories/film_repository'
# require_relative '../repositories/film_screening_repository'

require_relative '../lib/base_repository'

class ApplicationRepository < BaseRepository
  def self.types
    {
      cinema_hall_repository: CinemaHallRepository,
      film_repository: FilmRepository,
      film_screening_repository: FilmScreeningRepository
    }
  end
end
