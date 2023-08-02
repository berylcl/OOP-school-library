require_relative '../classroom'

RSpec.describe Classroom do
  describe '#add_student' do
    it 'associates the student with the classroom and adds the student to the list of students' do
      classroom = Classroom.new('Science Lab')
      student = Student.new(18, 'John Doe', true)
      classroom.add_student(student)

      expect(student.classroom).to eq(classroom)
      expect(classroom.students).to contain_exactly(student)
    end

    it 'does not duplicate the student in the list if already associated with the classroom' do
      classroom = Classroom.new('Literature Class')
      student = Student.new(16, 'Jane Smith', false)

      classroom.add_student(student)
      classroom.add_student(student)

      expect(student.classroom).to eq(classroom)
      expect(classroom.students).to include(student)
      expect(classroom.students.count(student)).to eq(1)
    end
  end
end
