require 'securerandom'
require_relative './application_entity'

class FilmScreening < ApplicationEntity
  attr_reader :id, :film, :cinema_hall, :time, :created_at

  def initialize(film, cinema_hall, time)
    @id = SecureRandom.uuid
    @film = film
    @cinema_hall = cinema_hall
    @time = time
    @created_at = Time.now
  end
end
