require_relative 'base_decorator'

class CapitalizeDecorator < BaseDecorator
  def method_missing(method, *args, &block)
    if @nameable.respond_to?(method)
      @nameable.send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    @nameable.respond_to?(method, include_private) || super
  end

  def correct_name
    @nameable.correct_name.capitalize
  end
end
