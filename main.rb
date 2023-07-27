require_relative 'app'

def print_options
  puts "\nOptions:"
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Quit'
end

def list_books(app)
  app.list_books
end

def list_people(app)
  app.list_people
end

def create_person(app)
  app.create_person
end

def create_book(app)
  app.create_book
end

def create_rental(app)
  app.create_rental
end

def list_rentals_for_person(app)
  app.list_rentals_for_person
end

def quit
  puts 'Goodbye!'
  exit
end

def main
  app = App.new

  loop do
    print_options
    print "\nEnter your choice (1-7): "
    choice = gets.chomp.to_i

    case choice
    when 1
      list_books(app)
    when 2
      list_people(app)
    when 3
      create_person(app)
    when 4
      create_book(app)
    when 5
      create_rental(app)
    when 6
      list_rentals_for_person(app)
    when 7
      quit
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

main
