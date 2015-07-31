## TODO: Implement CSV reading/writing
require 'csv'
require_relative 'contact'
#contacts = CSV.read('contacts.csv')
class DataBaseReadWrite
  
  def self.add_contact(contact_str)
    contacts = File.open("contacts.csv","a")
    contacts.puts contact_str
    contacts.close
  end

  # opened properly?
  # how to close file?

  def self.read_contact
    contacts = File.open("contacts.csv","r")
    unless file.eof?
      contact = contacts.readline
    end
    contact
  end

  def self.read_all_contacts
    contacts = File.open("contacts.csv","r")
    all_contacts = []
    while !contacts.eof?
      contact = contacts.readline
      contact = contact.split(',')
      # binding.pry
      contact = Contact.new(contact[1], contact[2], contact[0].to_i)
      all_contacts << contact
    # all_contacts << contacts.readline
    end
    all_contacts
  end

end
# def read
# end

# def write
#   end
#   


