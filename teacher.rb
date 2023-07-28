# FrozenStringLiteral: true

require_relative 'person'
class Teacher < Person
  def initialize(name = 'Unknown', age = 18, specialization)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
