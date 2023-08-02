require_relative '../base_decorator'
require_relative '../nameable'
RSpec.describe BaseDecorator do
  let(:nameable_object) { Nameable.new }
  describe '#initialize' do
    it 'sets the nameable object' do
      decorator = BaseDecorator.new(nameable_object)
      expect(decorator.nameable).to eq(nameable_object)
    end
  end
  describe '#correct_name' do
    it 'delegates the correct_name method to the nameable object' do
      allow(nameable_object).to receive(:correct_name).and_return('John Doe')
      decorator = BaseDecorator.new(nameable_object)
      expect(decorator.correct_name).to eq('John Doe')
    end
  end
end
