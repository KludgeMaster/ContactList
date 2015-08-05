# require_relative 'contact_database'
# require 'pry'
# require 'pg'


class Contact < ActiveRecord::Base
  
  def to_s
    "#{id}, #{first_name}, #{last_name}, (#{email})\n"
  end
  
  ## Class Methods
  class << self
    
    def search(term)
      list = []
      list << find_by_email(term)
      list << find_all_by_lastname(term)
      list << find_all_by_firstname(term)
    end



    def find_all_by_lastname(name)
      # query = "SELECT * FROM contacts WHERE lastname LIKE '%#{name}$';" 
      # This will return all rows that include 'name' in their lastname column.
      # result = CONN.exec_params('SELECT * FROM contacts WHERE lastname LIKE $1;',["%#{name}%"])
      # convert_to_contacts(result)
      self.where("last_name LIKE ('%#{name}%')")
    end

    def find_all_by_firstname(name)
      # result = CONN.exec_params('SELECT * FROM contacts WHERE firstname LIKE $1;',["%#{name}%"])
      # convert_to_contacts(result)
      self.where("first_name LIKE ('%#{name}%')")
    end

    def find_by_email(email)
      # result = CONN.exec_params('SELECT * FROM contacts WHERE email = $1;',["#{email}"])
      # convert_to_contacts(result)
      self.where("email LIKE ('%#{email}%')")
    end

   
  end
 
end