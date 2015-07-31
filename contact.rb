require_relative 'contact_database'
require 'pry'


class Contact
  # include DataBaseReadWrite
  attr_accessor :name, :email, :id
  @@class_id = 0
  

  def initialize(name, email, id = @@class_id)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
    @id = id
    @@class_id = id
    @@class_id += 1
  end

  @@contacts = DataBaseReadWrite.read_all_contacts
  
  def to_s
    # TODO: return string representation of Contact
    # binding.pry
    "#{id}, #{@name.gsub(/^\s+/,"")}, #{@email.gsub(/\s+/,"")}\n"
  end
 
  ## Class Methods
  class << self
    
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      #contacts << Contact.new(name,email) # will this work?
      my_contact = Contact.new(name, email)
      DataBaseReadWrite.add_contact(my_contact.to_s)
      @@contacts << my_contact
    end
    
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      #contacts.select {|contact| contact.include?(term) }
      # loop do
      #   contact = DataBaseReadWrite::read_contact
      #   return contact if contact.include?(term)
      # end
      # return "No contact containging '#{term}' found."
      my_contacts = []
      DataBaseReadWrite.read_all_contacts.each do |contact|
        my_contacts << contact if contact.to_s.include?(term)
      end
      if my_contacts.empty?
        "No contact containing '#{term}' found."
      end
      my_contacts
    end
 
    def all
      # TODO: Return the list of contacts, as is
      DataBaseReadWrite.read_all_contacts
      # @@contacts.each do |contact|
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      DataBaseReadWrite.read_all_contacts.each do |contact|
        contact_split = contact.to_s.split(',')
        puts contact if contact_split[0] == id
      end
    end
    
  end
 
end