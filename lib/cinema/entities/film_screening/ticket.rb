require 'securerandom'
require_relative '../application_entity'
require_relative '../../lib/validation'

class Ticket < ApplicationEntity
  include Validation

  attr_reader :id, :film_screening, :user, :place, :created_at

  validate :film_screening, :presence
  validate :user, :presence
  validate :place, :presence

  def initialize(film_screening, user, place)
    @id = SecureRandom.uuid
    @film_screening = film_screening
    @user = user
    @place = place
    @created_at = Time.now
  end
end
