require_relative 'contact'
require_relative 'contact_database'


require 'pry'
# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

puts "This is Ryan's contact list!"
puts "What would you like to do?"
puts "Enter 'Help' for a list of commands."
print '> '

user_input = gets.chomp

case user_input
  # binding.pry
  when "new"
    print "Name:"
    name = gets.chomp
    print "Email:"
    email = gets.chomp
    Contact.create(name,email)

  when "list"
    puts Contact.all
  
  when "show"
    print "Enter the ID you wish to look for: "
    id = gets.chomp
    Contact.show(id)
  when "find"
    print "Enter a term you wish to search for: "
    term = gets.chomp
    puts Contact.find(term)
  else 
    puts "Wrong command!! Try another command" unless user_input == "help"
    puts "Here is a list of available commands"
    puts "new - Create a new contact"
    puts "list - List all contacts"
    puts "show - show a contact"
    puts "find - Find a contact"
end
