module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :constrains

    def validate(*args)
      @constrains ||= {}
      name, type, *opt = args
      @constrains[name] ||= []
      @constrains[name] << { type: type, opt: opt }
    end
  end

  module InstanceMethods
    def validate!
      errors = {}

      self.class.constrains.each do |path, items|
        items.each do |c|
          attr_value = instance_variable_get("@#{path}")
          method = "validate_#{c[:type]}"
          result = send(method, attr_value, c[:opt])

          if result
            errors[path] ||= []
            errors[path] << result
          end
        end
      end

      errors.any? && errors
    end

    private

    def validate_presence(attr_value, _opt)
      error_message = 'You must input smth.'
      attr_value.to_s.strip.size.zero? && error_message
    end

    def validate_type(attr_value, opt)
      error_message = 'Wrong type'
      !attr_value.is_a?(opt[0]) && error_message
    end

    def validate_format(attr_value, opt)
      error_message = 'Invalid format'
      (attr_value.strip !~ opt[0]) && error_message
    end
  end
end
