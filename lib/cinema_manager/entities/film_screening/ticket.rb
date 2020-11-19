require 'securerandom'
require 'aasm'
require_relative '../application_entity'
require_relative '../../lib/validation'

class FilmScreeningTicket < ApplicationEntity
  include Validation
  include AASM

  aasm do
    state :active, initial: true
    state :returned

    event :refund do
      transitions from: :active, to: :returned
    end
  end

  attr_reader :id, :film_screening, :user, :place, :cost, :created_at

  validate :film_screening, :presence
  validate :user, :presence
  validate :place, :presence
  validate :cost, :presence

  def initialize(film_screening, user, place)
    @id = SecureRandom.uuid
    @film_screening = film_screening
    @user = user
    @place = place
    @cost = film_screening.cost
    @created_at = Time.now
  end
end
