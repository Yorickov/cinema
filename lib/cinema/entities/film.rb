require 'securerandom'
require_relative './application_entity.rb'

class Film < ApplicationEntity
  attr_reader :id, :name, :duration, :created_at

  def initialize(name, duration)
    # super
    @id = SecureRandom.uuid
    @name = name
    @duration = duration
    @created_at = Time.now
  end
end
