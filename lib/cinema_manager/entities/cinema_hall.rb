require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class CinemaHall < ApplicationEntity
  include Validation

  attr_reader :id, :name, :rows, :cols, :created_at

  validate :name, :presence
  validate :rows, :presence
  validate :rows, :type, Integer
  validate :cols, :presence
  validate :cols, :type, Integer

  def initialize(name, rows, cols)
    @id = SecureRandom.uuid
    @name = name
    @rows = rows
    @cols = cols
    @created_at = Time.now
  end
end
