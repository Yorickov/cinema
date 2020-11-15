require 'cinema/services/cinema_service'
require 'cinema/services/money_service'
require 'cinema/services/user_service'
require 'cinema/repositories/cinema_hall_repository'
require 'cinema/repositories/film_repository'
require 'cinema/repositories/film_screening_repository'
require 'cinema/repositories/film_screening/ticket_repository'
require 'cinema/repositories/user_repository'

describe 'MoneyService' do
  before(:each) do
    repo_types = {
      cinema_hall_repository: CinemaHallRepository,
      film_repository: FilmRepository,
      film_screening_repository: FilmScreeningRepository,
      user_repository: UserRepository,
      ticket_repository: TicketRepository
    }
    repository_instances = repo_types.each_with_object({}) do |(key, value), acc|
      acc[key] = value.new
    end

    @cinema_service = CinemaService.new(repository_instances)
    @user_service = UserService.new(repository_instances)
    @money_service = MoneyService.new(repository_instances)

    @film = @cinema_service.create_film('the appartment', 120)
    @cinema_hall = @cinema_service.create_cinema_hall('hall 1', 30, 50)
    @film_screening = @cinema_service.create_film_screening(@film.id, @cinema_hall.id, Time.new)
  end

  it 'create user' do
    email = 'example@hoo.com'
    user = @user_service.create_user(email)
    expect(user).to have_attributes(email: email)
  end

  it 'buy ticket' do
    email = 'example@hoo.com'
    user = @user_service.create_user(email)
    place = 35
    ticket = @money_service.buy_ticket(user.id, @film_screening.id, place)

    expect(ticket).to have_attributes(place: place)
    expect(ticket.film_screening).to have_attributes(time: @film_screening.time)
    expect(ticket.user).to have_attributes(email: email)
  end
end
