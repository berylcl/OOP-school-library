require_relative '../capitalize_decorator'
require_relative '../person'
RSpec.describe CapitalizeDecorator do
  let(:person) { Person.new(30, 'john doe') }
  let(:decorated_person) { CapitalizeDecorator.new(person) }
  describe '#correct_name' do
    it 'capitalizes the name returned by the decorated object' do
      expect(decorated_person.correct_name).to eq('John doe')
    end
  end
  it 'does not modify the original object' do
    decorated_person.correct_name
    expect(person.correct_name).to eq('john doe')
  end
  it 'correctly delegates other methods to the decorated object' do
    expect(decorated_person.age).to eq(30)
    expect(decorated_person.can_use_services?).to be(true)
  end
end
