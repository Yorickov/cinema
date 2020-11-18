require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class Film < ApplicationEntity
  include Validation

  attr_reader :id, :name, :duration, :created_at

  validate :name, :presence
  validate :duration, :presence
  validate :duration, :type, Integer

  def initialize(name, duration)
    @id = SecureRandom.uuid
    @name = name
    @duration = duration
    @created_at = Time.now
  end
end
