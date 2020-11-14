require 'securerandom'

class CinemaHall
  attr_reader :id, :name, :rows, :cols, :film_screenings, :created_at

  def initialize(name, rows, cols)
    @id = SecureRandom.uuid
    @name = name
    @rows = rows
    @cols = cols
    @film_screenings = []
    @created_at = Time.now
  end

  def add_film_screening(film_screening)
    film_screenings << film_screening
  end
end
