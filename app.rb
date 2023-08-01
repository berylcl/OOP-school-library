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

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  def list_people
    puts 'List of People:'
    @people.each { |person| puts "ID: #{person.id}, #{person.class.name}: #{person.name}" }
  end

  def list_books
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts "#{index}. #{book.title} by #{book.author}" }
  end

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

  def save_books
    File.open('books.json', 'w') do |file|
      file.write(JSON.generate(@books.map { |book| { title: book.title, author: book.author } }))
    end
  end

  def save_people
    File.open('people.json', 'w') do |file|
      file.write(JSON.generate(@people.map do |person|
        {
          id: person.id,
          name: person.name,
          age: person.age,
          parent_permission: person.instance_variable_get(:@parent_permission),
          classroom_label: person.classroom&.label
        }
      end))
    end
  end

  def save_rentals
    File.open('rentals.json', 'w') do |file|
      file.write(JSON.generate(@rentals.map do |rental|
        {
          date: rental.date.to_s,
          book_title: rental.book.title,
          book_author: rental.book.author,
          person_id: rental.person.id
        }
      end))
    end
  end

  def load_books
    if File.exist?('books.json')
      books_data = File.read('books.json')
      if books_data.empty?
        puts "The 'books.json' file is empty. Starting with an empty list of books."
        @books = []
      else
        @books = JSON.parse(books_data).map { |data| Book.new(data['title'], data['author']) }
      end
    else
      puts "No 'books.json' file found. Starting with an empty list of books."
      @books = []
    end
  end

  def load_people
    if File.exist?('people.json')
      people_data = JSON.parse(File.read('people.json'))
      @people = people_data.map do |data|
        if data['classroom_label']
          classroom = Classroom.new(data['classroom_label'])
          data['classroom'] = classroom
        end
        if data['parent_permission']
          Student.new(data['age'], data['name'], data['parent_permission'])
        else
          Teacher.new(data['name'], data['age'], data['specialization'])
        end
      end
    else
      puts "No 'people.json' file found. Starting with an empty list of people."
    end
  end

  def load_rentals
    if File.exist?('rentals.json')
      rentals_data = JSON.parse(File.read('rentals.json'))
      @rentals = rentals_data.map do |data|
        book = @books.find { |b| b.title == data['book_title'] && b.author == data['book_author'] }
        person = @people.find { |p| p.id == data['person_id'] }
        Rental.new(Date.parse(data['date']), book, person) if book && person
      end.compact
    else
      puts "No 'rentals.json' file found. Starting with an empty list of rentals."
    end
  end

  def quit
    puts 'Goodbye!'
    exit
  end
end
