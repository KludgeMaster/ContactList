# require_relative 'contact_database'
require 'pry'
require 'pg'


class Contact
  # include DataBaseReadWrite
  attr_accessor :firstname, :lastname, :email, :id
  CONN = PG::Connection.new(host: 'localhost', port: 5432, user: 'development',password: 'development', dbname: 'contact_list')
  

  def initialize(firstname, lastname, email, id =0)
    # TODO: assign local variables to instance variables
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id if id.to_i > 0
  end

  #@@contacts = DataBaseReadWrite.read_all_contacts
  
  def to_s
    # TODO: return string representation of Contact
    # binding.pry
    "#{id}, #{@firstname.gsub(/^\s+/,"")},#{@lastname.gsub(/^\s+/,"")}, (#{@email.gsub(/\s+/,"")})\n"
  end
  
  def save
    if id
      # query = "UPDATE contacts SET firstname = '#{firstname}', latename = '#{lastname}', email = '#{email}' WHERE id = #{id};"
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4',["#{firstname}","#{lastname}","#{email}", "#{id}"])
    else 
      # query = "INSERT INTO contacts (firstname, lastname, email) VALUES ('#{firstname}', '#{lastname}', '#{email}');"
      CONN.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3)',["#{firstname}","#{lastname}","#{email}"])
    end
    # CONN.exec(query)
  end

  def destroy
    CONN.exec_params('DELETE FROM contacts WHERE id = $1',["#{id}"])
    # query = "DELETE FROM contacts WHERE id = #{id};"
    # CONN.exec(query)
  end


  ## Class Methods
  class << self
    
    # def create(name, email)
    #   # TODO: Will initialize a contact as well as add it to the list of contacts
    #   #contacts << Contact.new(name,email) # will this work?
    #   my_contact = Contact.new(name, email)
    #   DataBaseReadWrite.add_contact(my_contact.to_s)
    #   @@contacts << my_contact
    # end
    
    def find(id)
      # query = "SELECT * FROM contacts WHERE id = #{id};"
      # temp = CONN.exec(query)
      result = CONN.exec_params('SELECT * FROM contacts WHERE id = $1;',["#{id}"])
      # puts temp[0] 
      # Contact.new(temp[0]["firstname"], temp[0]["lastname"], temp[0]["email"], temp[0]["id"].to_i)
      convert_to_contacts(result)[0]
    end

    def find_all_by_lastname(name)
      # query = "SELECT * FROM contacts WHERE lastname LIKE '%#{name}$';" 
      # This will return all rows that include 'name' in their lastname column.
      result = CONN.exec_params('SELECT * FROM contacts WHERE lastname LIKE $1;',["%#{name}%"])
      convert_to_contacts(result)
    end

    def find_all_by_firstname(name)
      result = CONN.exec_params('SELECT * FROM contacts WHERE firstname LIKE $1;',["%#{name}%"])
      convert_to_contacts(result)
    end

    def find_by_email(email)
      result = CONN.exec_params('SELECT * FROM contacts WHERE email = $1;',["#{email}"])
      convert_to_contacts(result)
    end

    def show_all
      # Show me everything in the table (it's not much for now)
      result = CONN.exec_params('SELECT * FROM contacts;')
      # query = "SELECT * FROM contacts;"
      # CONN.exec(query)
      all = convert_to_contacts(result)
      result_str = []
      all.each do |contact|
        result_str << contact.to_s
      end
    end

    private
    def convert_to_contacts (result)
      contacts=[]
      result.each do |contact|
        contacts << Contact.new(contact[:firstname.to_s], contact[:lastname.to_s], contact[:email.to_s], contact[:id.to_s].to_i)
      end
      # binding.pry
      contacts
    end

    # def all
    #   # TODO: Return the list of contacts, as is
    #   DataBaseReadWrite.read_all_contacts
    #   # @@contacts.each do |contact|
    # end
    
    # def show(id)
    #   # TODO: Show a contact, based on ID
    #   DataBaseReadWrite.read_all_contacts.each do |contact|
    #     contact_split = contact.to_s.split(',')
    #     puts contact if contact_split[0] == id
    #   end
    # end
    
  end
 
end