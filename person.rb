# FrozenStringLiteral: true
# person.rb
class Person
  attr_accessor :name, :age, :rentals, :classroom
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || parent_permission
  end

  def correct_name
    @name
  end

  def of_age?
    @age >= 18
  end

  private :of_age?
end
