
require_relative '../book'

RSpec.describe Book do
  describe '#initialize' do
    it 'creates a book with the correct title and author' do
      book = Book.new('Harry Potter', 'J.K. Rowling')
      expect(book.title).to eq('Harry Potter')
      expect(book.author).to eq('J.K. Rowling')
    end
  end

  describe '#title' do
    it 'can be changed' do
      book = Book.new('Title 1', 'Author 1')
      book.title = 'New Title'
      expect(book.title).to eq('New Title')
    end
  end

  describe '#author' do
    it 'can be changed' do
      book = Book.new('Title 1', 'Author 1')
      book.author = 'New Author'
      expect(book.author).to eq('New Author')
    end
  end
end
