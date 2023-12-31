# FrozenStringLiteral: true

class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    return if students.include?(student)

    students << student
    student.classroom = self
  end
end
