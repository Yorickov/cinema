require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class Price < ApplicationEntity
  include Validation

  WEEKEND_MULTIPLIER = 1.3

  attr_reader :id, :value, :cinema_hall, :created_at

  validate :value, :presence
  validate :value, :type, Integer
  validate :cinema_hall, :presence

  def initialize(value, cinema_hall)
    @id = SecureRandom.uuid
    @value = value
    @cinema_hall = cinema_hall
    @created_at = Time.now
  end

  def calculate_for(time)
    raise 'Wrong time format' unless time.is_a? Time

    time.sunday? ? (value * WEEKEND_MULTIPLIER) : value
  end
end
