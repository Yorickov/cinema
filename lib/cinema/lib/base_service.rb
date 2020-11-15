class BaseService
  def initialize(repositories)
    repositories.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.define_method(key) { instance_variable_get("@#{key}".to_sym) }
    end
  end
end
