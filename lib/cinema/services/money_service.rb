require_relative './application_service'
require_relative '../entities/film_screening/ticket'

class MoneyService < ApplicationService
  def buy_ticket(user_id, film_screening_id, place)
    user = user_repository.find(user_id)
    screening = film_screening_repository.find(film_screening_id)
    ticket = Ticket.new(screening, user, place)
    ticket_repository.save(ticket)
    ticket
  end
end
