require_relative '../rental'
require 'date'
RSpec.describe Rental do
  describe '#initialize' do
    it 'creates a rental with the correct date, book, and person' do
      date = Date.new(2023, 8, 1)
      book = Book.new('Book Title', 'Author Name')
      person = Person.new(25, 'John Doe')
      rental = Rental.new(date, book, person)
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end
end
