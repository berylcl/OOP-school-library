require_relative '../teacher'

RSpec.describe Teacher do
  describe '#initialize' do
    it 'creates a teacher with the correct age, name, and specialization' do
      teacher = Teacher.new('John Smith', 30, 'Mathematics')
      expect(teacher.age).to eq(30)
      expect(teacher.name).to eq('John Smith')
      expect(teacher.instance_variable_get(:@specialization)).to eq('Mathematics')
    end

    it 'has default age as 18 and specialization as "Unknown"' do
      teacher = Teacher.new('Jane Doe')
      expect(teacher.age).to eq(18)
      expect(teacher.name).to eq('Jane Doe')
      expect(teacher.instance_variable_get(:@specialization)).to eq('Unknown')
    end
  end

  describe '#can_use_services?' do
    it 'returns true, as teachers can use services' do
      teacher = Teacher.new('John Doe', 25, 'Physics')
      expect(teacher.can_use_services?).to be(true)
    end
  end
end
