
require 'pry'
require 'pg'
require_relative 'setup'
require_relative 'contact'
require_relative 'contact_list'


puts '---------------------------------------------------'
puts 'Adding some contacts to start with.....'

c1 = Contact.create(first_name: "Ryan", last_name: "Song", email: "yiryans@gmail.com")
c2 = Contact.create(first_name: "Ashley", last_name: "Chun", email: "ashley@gmail.com")
c3 = Contact.create(first_name: "Bat", last_name: "Man", email: "imdark@gmail.com")
c4 = Contact.create(first_name: "Spider", last_name: "Man", email: "ibelieveicanfly@gmail.com")
c5 = Contact.create(first_name: "Super", last_name: "Man", email: "wasabi_killer@gmail.com")

if c1.valid? && c2.valid? && c3.valid? && c4.valid? && c5.valid?
  puts "Contacts successfully added to Database"
else
  puts c1.errors.messaage
end


loop do 
  puts "This is Ryan's contact list!"
  puts "What would you like to do?"
  puts "Enter 'Help' for a list of commands."
  print '> '

  user_input = gets.chomp


  case user_input
    # binding.pry
    when "new"
      print "First Name :"
      first_name = gets.chomp
      print "Last Name :"
      last_name = gets.chomp
      print "Email:"
      email = gets.chomp
      Contact.create(first_name: first_name,last_name: last_name, email: email)

    when "list"
      puts Contact.all
    
    when "show"
      print "Enter the ID you wish to look for: "
      id = gets.chomp
      puts Contact.find(id)

    when "search"
      print "Enter a term you wish to search for: "
      term = gets.chomp
      puts Contact.search(term)
    else 
      puts "Wrong command!! Try another command" unless user_input == "help"
      puts "Here is a list of available commands"
      puts "new - Create a new contact"
      puts "list - List all contacts"
      puts "show - Show a contact"
      puts "search - Search for a term"
  end
  break if user_input == "quit"
end
