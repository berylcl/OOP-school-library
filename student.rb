require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name, age, parent_permission = false)
    super(name, age)
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
