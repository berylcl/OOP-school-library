require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name, age)
    super(name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
