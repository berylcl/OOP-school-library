require_relative 'person'

class Student < Person
  attr_accessor :parent_permission

  def initialize(name, age, parent_permission = false)
    super(name, age)
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
