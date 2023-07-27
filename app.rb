require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_people
    puts 'List of People:'
    @people.each { |person| puts 'ID: #{person.id}, #{person.class.name}: #{person.name}' }
  end

  def list_books
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts '#{index}. #{book.title} by #{book.author}' }
  end

  def create_person
    puts "Enter the person's name:"
    name = gets.chomp

    puts "Enter the person's age:"
    age = gets.chomp.to_i

    puts 'Is the person a student? (yes/no):'
    is_student = gets.chomp.downcase

    if is_student == 'yes'
      @people << Student.new(name, age)
    else
      @people << Teacher.new(name, age)
    end

    puts "#{name} has been added as a #{is_student == 'yes' ? 'student' : 'teacher'}."
  end

  def create_book
    puts "Enter the book's title:"
    title = gets.chomp

    puts "Enter the book's author:"
    author = gets.chomp

    @books << Book.new(title, author)

    puts "#{title} by #{author} has been added to the library."
  end

  def create_rental
    list_people
    puts "Enter the person's id to create a rental:"
    person_id = gets.chomp.to_i

    list_books
    puts "Enter the book's index to create a rental:"
    book_index = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }
    book = @books[book_index]

    if person && book
      rental = Rental.new(Date.today, book, person)
      @rentals << rental
      puts "Rental created: #{person.name} rented '#{book.title}'."
    else
      puts 'Invalid person ID or book index.'
    end
  end

  def list_rentals_for_person
    list_people
    puts "Enter the person's id to list their rentals:"
    begin
      person_id = Integer(gets.chomp)
    rescue ArgumentError
      puts 'Invalid input for person ID. Please enter a valid integer.'
      return
    end

    person = @people.find { |p| p.id == person_id }

    if person
      rentals = @rentals.select { |rental| rental.person == person }
      puts "#{person.name}'s Rentals:"
      rentals.each do |rental|
        puts "- #{rental.book.title}, rented on #{rental.date}"
      end
    else
      puts 'Invalid person ID.'
    end
  end
end
