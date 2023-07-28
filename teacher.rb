# FrozenStringLiteral: true

require_relative 'person'
class Teacher < Person
  def initialize(name, age = 18, specialization = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
