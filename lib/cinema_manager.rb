require 'dry-container'

require_relative './cinema_manager/entities/film'
require_relative './cinema_manager/entities/cinema_hall'
require_relative './cinema_manager/entities/film_screening'
require_relative './cinema_manager/entities/film_screening/ticket'
require_relative './cinema_manager/entities/user'
require_relative './cinema_manager/entities/price'
require_relative './cinema_manager/entities/capital_transaction'

require_relative './cinema_manager/repositories/film_repository'
require_relative './cinema_manager/repositories/cinema_hall_repository'
require_relative './cinema_manager/repositories/film_screening_repository'
require_relative './cinema_manager/repositories/film_screening/ticket_repository'
require_relative './cinema_manager/repositories/user_repository'
# require_relative './cinema_manager/repositories/repositories'
require_relative './cinema_manager/repositories/capital_transaction_repository'
require_relative './cinema_manager/repositories/price_repository'

require_relative './cinema_manager/services/cinema_service'
require_relative './cinema_manager/services/money_service'
require_relative './cinema_manager/services/user_service'

class CinemaManager
  extend Dry::Container::Mixin

  register(
    'entities', {
      film: Film,
      cinema_hall: CinemaHall,
      film_screening: FilmScreening,
      film_screening_ticket: FilmScreeningTicket,
      user: User,
      capital_transaction: CapitalTransaction,
      price: Price
    }
  )

  register(
    'repositories', {
      film: FilmRepository.new,
      cinema_hall: CinemaHallRepository.new,
      film_screening: FilmScreeningRepository.new,
      film_screening_ticket: FilmScreeningTicketRepository.new,
      user: UserRepository.new,
      capital_transaction: CapitalTransactionRepository.new,
      price: PriceRepository.new
    }
  )

  register(
    'services', {
      cinema: CinemaService.new(
        resolve('entities'),
        resolve('repositories')
      ),
      money: MoneyService.new(
        resolve('entities'),
        resolve('repositories')
      ),
      user: UserService.new(
        resolve('entities'),
        resolve('repositories')
      )
    }
  )
end
