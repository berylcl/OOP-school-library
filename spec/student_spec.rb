require_relative '../student'
require_relative '../classroom'

RSpec.describe Student do
  describe '#initialize' do
    it 'creates a student with the correct age and name' do
      student = Student.new(18, 'John Doe', true)
      expect(student.age).to eq(18)
      expect(student.name).to eq('John Doe')
    end

    it 'has parent permission by default' do
      student = Student.new(15, 'Jane Doe', true)
      expect(student.instance_variable_get(:@parent_permission)).to be(true)
    end
  end

  describe '#classroom=' do
    it 'associates the student with a classroom' do
      classroom = Classroom.new('Math Class')
      student = Student.new(16, 'Alice', true)
      student.classroom = classroom
      expect(student.classroom).to eq(classroom)
      expect(classroom.students).to include(student)
    end

    it 'does not add the student to the classroom if already associated' do
      classroom = Classroom.new('Science Lab')
      student = Student.new(17, 'Bob', true)
      student.classroom = classroom
      student.classroom = classroom
      expect(classroom.students.count(student)).to eq(1)
    end
  end

  describe '#play_hooky' do
    it 'returns the "play hooky" emoji' do
      student = Student.new(15, 'Eve', true)
      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end
end
