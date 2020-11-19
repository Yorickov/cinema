require 'securerandom'
require_relative './application_entity'
require_relative '../lib/validation'

class CapitalTransaction < ApplicationEntity
  include Validation

  attr_reader :id, :ticket, :cost, :created_at

  validate :ticket, :presence
  validate :cost, :presence
  validate :cost, :type, Integer

  def initialize(ticket, type)
    @id = SecureRandom.uuid
    @ticket = ticket
    @created_at = Time.now

    case type
    when 'income'
      @cost = ticket.cost
    when 'loss'
      @cost = -ticket.cost
    end
  end
end
