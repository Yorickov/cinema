require 'securerandom'

class FilmScreening
  attr_reader :id, :film, :cinema_hall, :time, :created_at

  def initialize(film, cinema_hall, time)
    @id = SecureRandom.uuid
    @film = film
    @cinema_hall = cinema_hall
    @time = time
    @created_at = Time.now

    cinema_hall.add_film_screening(self)
  end
end
