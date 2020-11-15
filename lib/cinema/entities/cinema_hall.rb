require 'securerandom'
require_relative './application_entity.rb'

class CinemaHall < ApplicationEntity
  attr_reader :id, :name, :rows, :cols, :created_at

  def initialize(name, rows, cols)
    # super
    @id = SecureRandom.uuid
    @name = name
    @rows = rows
    @cols = cols
    @created_at = Time.now
  end
end
