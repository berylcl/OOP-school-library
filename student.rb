# FrozenStringLiteral: true

require_relative 'person'

class Student < Person
  def initialize(classroom, name: 'Unknown', age: 18, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end


