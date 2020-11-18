require 'cinema_manager'

describe 'Cinema Service' do
  before(:each) do
    @service = CinemaManager['services'][:cinema]
  end

  it 'creates film' do
    film, _errors = @service.create_film('the appartment', 120)
    expect(film).to have_attributes(name: 'the appartment', duration: 120)
  end

  it 'creates film (errors)' do
    _film, errors = @service.create_film('', '')
    expected = {
      name: ['You must input smth.'],
      duration: ['You must input smth.', 'Wrong type']
    }
    expect(errors).to eq(expected)
  end

  it 'create cinema hall' do
    cinema_hall, _errors = @service.create_cinema_hall('hall 1', 30, 50)
    expect(cinema_hall).to have_attributes(name: 'hall 1', rows: 30, cols: 50)
  end

  it 'creates cinema hall (errors)' do
    _cinema_hall, errors = @service.create_cinema_hall('', 'sc', 50)
    expected = {
      name: ['You must input smth.'],
      rows: ['Wrong type']
    }
    expect(errors).to eq(expected)
  end
end
