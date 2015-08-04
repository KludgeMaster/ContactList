require_relative 'contact'



# Create a new contact
 super_man = Contact.new("super", "Man", "ibelieveicanfly@gmail.com")
 super_man.save

# Show everything in contact_list
 puts Contact.show_all

# Find id#3
 puts Contact.find(3)

# Find all entries that include 'Ryan' in their firstname column
 puts Contact.find_all_by_firstname('Ryan')

# Find an entry with matching email
 puts Contact.find_by_email('yiryans@gmail.com')

# Destroy a spy!!!
spy = Contact.find(14)
spy.destroy
puts Contact.show_all
