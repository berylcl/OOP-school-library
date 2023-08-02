
require_relative '../person'
require 'date'

RSpec.describe Person do
  describe '#initialize' do
    it 'creates a person with the correct age and name' do
      person = Person.new(25, 'John Doe')
      expect(person.age).to eq(25)
      expect(person.name).to eq('John Doe')
    end

    it 'has parent permission by default' do
      person = Person.new(15)
      expect(person.instance_variable_get(:@parent_permission)).to be(true)
    end
  end

  describe '#id' do
    it 'returns a number between 1 and 1000' do
      person = Person.new(18)
      expect(person.id).to be_between(1, 1000).inclusive
    end
  end

  describe '#can_use_services?' do
    it 'returns true if the person is of age' do
      person = Person.new(20)
      expect(person.can_use_services?).to be(true)
    end

    it 'returns true if the person has parent permission' do
      person = Person.new(15)
      expect(person.can_use_services?).to be(true)
    end

    it 'returns false if the person is below age 18 and has no parent permission' do
      person = Person.new(15, 'Jane Doe', parent_permission: false)
      expect(person.can_use_services?).to be(false)
    end
  end

  describe '#correct_name' do
    it 'returns the name as it is' do
      person = Person.new(30, 'Bob')
      expect(person.correct_name).to eq('Bob')
    end
  end

  describe 'private methods' do
    subject(:person) { Person.new(25) }

    describe '#of_age?' do
      it 'returns true if the person is 18 or older' do
        expect(person.send(:of_age?)).to be(true)
      end

      it 'returns false if the person is younger than 18' do
        person.instance_variable_set(:@age, 15)
        expect(person.send(:of_age?)).to be(false)
      end
    end
  end
end
