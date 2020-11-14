require 'securerandom'

class Film
  attr_reader :id, :name, :duration, :created_at

  def initialize(name, duration)
    @id = SecureRandom.uuid
    @name = name
    @duration = duration
    @created_at = Time.now
  end
end
