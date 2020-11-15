require 'securerandom'
require_relative '../application_entity.rb'

class Ticket < ApplicationEntity
  attr_reader :id, :film_screening, :user, :place, :created_at

  def initialize(film_screening, user, place)
    @id = SecureRandom.uuid
    @film_screening = film_screening
    @user = user
    @place = place
    @created_at = Time.now
  end
end
