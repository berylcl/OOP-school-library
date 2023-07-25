# FrozenStringLiteral: true

class Person
  attr_reader :id, :name, :age

  def initialize(name: 'Unknown', age: 18, parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    rand(1000..9999)
  end
end