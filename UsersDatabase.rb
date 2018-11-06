require 'sqlite3'
require 'singleton'
class UsersDatabase < SQLite3::Database
include Singleton
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true
    end
end

class Users
  attr_accessor :fname, :lname
  def self.all
    data = UsersDatabase.instance.execute("SELECT * FROM users")
   data.map { |datum| Users.new(datum) }
 end
 def self.find_by_id(id)
   user = UsersDatabase.instance.execute(<<-SQL, id)
   SELECT 
    *
  FROM 
  users
  WHERE 
  id = ?
  SQL
  Users.new(user.first)
 end
 def self.find_by_name(name)
   user = UsersDatabase.instance.execute(<<-SQL, name)
   SELECT 
    *
  FROM 
  users
  WHERE 
  fname = ?
  SQL
  Users.new(user.first)
 end
 

 def initialize(options)
   @fname = options['fname']
   @lname = options['lname']
   
 end
end