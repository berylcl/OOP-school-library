require_relative '../nameable'
require_relative '../base_decorator'
require_relative '../trimmer_decorator'
RSpec.describe TrimmerDecorator do
  let(:nameable_object) { Nameable.new }
  describe '#correct_name' do
    it 'trims the name to the first 10 characters' do
      allow(nameable_object).to receive(:correct_name).and_return('John Doe Smith')
      decorator = TrimmerDecorator.new(nameable_object)
      expect(decorator.correct_name).to eq('John Doe S')
    end
    it 'does not trim the name if it is already less than or equal to 10 characters' do
      allow(nameable_object).to receive(:correct_name).and_return('Jane')
      decorator = TrimmerDecorator.new(nameable_object)
      expect(decorator.correct_name).to eq('Jane')
    end
  end
end
