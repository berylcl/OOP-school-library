require_relative 'app'
require 'json'

OPTIONS = {
  1 => :list_books,
  2 => :list_people,
  3 => :create_person,
  4 => :create_book,
  5 => :create_rental,
  6 => :list_rentals_for_person,
  7 => :quit
}.freeze

def print_options
  puts "\nOptions:"
  OPTIONS.each { |num, description| puts "#{num}. #{description.capitalize}" }
end

def main
  app = App.new
  app.load_data

  at_exit do
    app.save_data
    puts 'See you again!'
  end
  loop do
    print_options
    print "\nEnter your choice (1-7): "
    choice = gets.chomp.to_i

    if OPTIONS.key?(choice)
      action = OPTIONS[choice]
      app.send(action)
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end

main
