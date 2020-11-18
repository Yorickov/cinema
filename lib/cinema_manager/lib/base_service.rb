class BaseService
  def initialize(entities, repositories)
    @entities = entities
    @repositories = repositories
  end

  protected

  attr_reader :entities, :repositories
end
