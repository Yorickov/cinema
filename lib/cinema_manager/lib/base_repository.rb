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

  def find_by(params)
    key, value = params.to_a[0]
    result = data.select { |entity| entity.send(key) == value }
    result.any? ? result.first : nil
  end

  def save(entity)
    data << entity
  end

  protected

  attr_reader :data
end
