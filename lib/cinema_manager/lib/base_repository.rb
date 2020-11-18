class BaseRepository
  def initialize
    @data = []
  end

  def all
    data
  end

  def find(id)
    result = data.find { |entity| entity.id == id }
    raise 'Entity not found' unless result

    result
  end

  def save(entity)
    data << entity
  end

  protected

  attr_reader :data
end
