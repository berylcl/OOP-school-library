# FrozenStringLiteral: true

require_relative 'person'

class Teacher < Person
  def initialize(specialization, name: 'Unknown', age: 18, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end