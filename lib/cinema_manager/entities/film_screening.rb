require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class FilmScreening < ApplicationEntity
  include Validation

  attr_reader :id, :film, :cinema_hall, :time, :cost, :created_at

  validate :film, :presence
  validate :cinema_hall, :presence
  validate :time, :presence
  validate :cost, :presence
  validate :cost, :type, Integer

  def initialize(film, cinema_hall, time, cost)
    @id = SecureRandom.uuid
    @film = film
    @cinema_hall = cinema_hall
    @time = time
    @cost = cost
    @created_at = Time.now
  end
end
