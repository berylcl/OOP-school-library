require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age = 18, name = 'Unknown', parent_permission = true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
