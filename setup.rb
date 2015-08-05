require 'pry'
require 'active_record'
require 'pg'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'ar_exercises',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'


puts 'Setting up Database (recreating tables) ...'

ActiveRecord::Schema.define do
  drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  create_table :contacts do |contact|
    contact.column :first_name, :string
    contact.column :last_name, :string
    contact.column :email, :string
    contact.timestamps null: false
  end
end

puts 'Setup DONE'

