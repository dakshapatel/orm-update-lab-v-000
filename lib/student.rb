require_relative "../config/environment.rb"

class Student

  attr_accessor :name, :grade, :id

  def initialize(id:, name:, grade:)
    @name = name
    @grade = grade
    @id = nil

  end

  def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
  )
  SQL

  DB[:conn].execute(sql)
end



  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
