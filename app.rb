require 'json'
require 'date'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

module Saveable
  # Save books data to 'books.json' file.
  def save_books
    File.write('books.json', JSON.generate(@books.map { |book| { title: book.title, author: book.author } }))
  end

  # Save people data to 'people.json' file.
  def save_people
    File.write('people.json', JSON.generate(@people.map do |person|
      {
        id: person.id,
        name: person.name,
        age: person.age,
        parent_permission: person.instance_variable_get(:@parent_permission),
        classroom_label: person.classroom&.label
      }
    end))
  end

  # Save rentals data to 'rentals.json' file.
  def save_rentals
    File.write('rentals.json', JSON.generate(@rentals.map do |rental|
      {
        date: rental.date.to_s,
        book_title: rental.book.title,
        book_author: rental.book.author,
        person_id: rental.person.id
      }
    end))
  end
end

class App
  attr_accessor :people, :books, :rentals

  include Loadable
  include Saveable
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  # Save data to the respective JSON files.
  def save_data
    save_books
    save_people
    save_rentals
  end

  # List all people.
  def list_people
    puts 'List of People:'
    @people.each { |person| puts "ID: #{person.id}, #{person.class.name}: #{person.name}" }
  end

  # List all books.
  def list_books
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts "#{index}. #{book.title} by #{book.author}" }
  end

  # Create a new person (student or teacher).
  def create_person
    puts "Enter the person's name:"
    name = gets.chomp

    puts "Enter the person's age:"
    age = gets.chomp.to_i

    puts 'Is the person a student? (yes/no):'
    is_student = gets.chomp.downcase

    if is_student == 'yes'
      puts 'Does the student have parent permission? (yes/no):'
      parent_permission = gets.chomp.downcase == 'yes'
      @people << Student.new(name, age, parent_permission)
      puts "#{name} has been added as a student."
    elsif is_student == 'no'
      puts "Enter the teacher's specialization:"
      specialization = gets.chomp
      @people << Teacher.new(name, age, specialization)
      puts "#{name} has been added as a teacher with specialization in #{specialization}."
    else
      puts 'Invalid input. Please enter either "yes" or "no".'
    end
  end

  # Create a new book.
  def create_book
    puts "Enter the book's title:"
    title = gets.chomp

    puts "Enter the book's author:"
    author = gets.chomp

    @books << Book.new(title, author)

    puts "#{title} by #{author} has been added to the library."
  end

  # Create a new rental record.
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

  # List all rentals for a specific person.
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

  # Quit the application.
  def quit
    puts 'Goodbye!'
    exit
  end
end
