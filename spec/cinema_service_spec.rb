require 'cinema/services/cinema_service'
require 'cinema/repositories/cinema_hall_repository'
require 'cinema/repositories/film_repository'
require 'cinema/repositories/film_screening_repository'

describe 'CinemaService' do
  before(:each) do
    repo_types = {
      cinema_hall_repository: CinemaHallRepository,
      film_repository: FilmRepository,
      film_screening_repository: FilmScreeningRepository
    }
    repository_instances = repo_types.each_with_object({}) do |(key, value), acc|
      acc[key] = value.new
    end
    @service = CinemaService.new(repository_instances)
  end

  it 'create film' do
    film = @service.create_film('the appartment', 120)
    expect(film).to have_attributes(name: 'the appartment', duration: 120)
  end

  it 'create cinema hall' do
    cinema_hall = @service.create_cinema_hall('hall 1', 30, 50)
    expect(cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)
  end

  it 'film screening' do
    time = Time.new
    film = @service.create_film('the appartment', 120)
    cinema_hall = @service.create_cinema_hall('hall 1', 30, 50)
    film_screening = @service.create_film_screening(film.id, cinema_hall.id, time)

    expect(film_screening).to have_attributes(time: time)
    expect(film_screening.film).to have_attributes(name: 'the appartment', duration: 120)
    expect(film_screening.cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)
  end
end
