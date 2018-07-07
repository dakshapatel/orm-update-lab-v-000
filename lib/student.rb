require_relative "../config/environment.rb"

class Student

  attr_accessor :name, :grade, :id


    def initialize(name, grade, id = nil)
      @id = nil
      @name = name
      @grade = grade
      #binding.pry
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

  def self.drop_table
      sql = "DROP TABLE IF EXISTS students"
      DB[:conn].execute(sql)
    end


    def save
    sql = <<~SQL
    INSERT INTO students(name, grade) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end


  def self.find_by_name(name)
      sql = <<~SQL
        SELECT * FROM students
        WHERE name = ?
        LIMIT 1
        SQL

        DB[:conn].execute(sql, name).map do |row|
        self.new_from_db(row)
      end.first
    end

    def self.new_from_db(row)
       new_name = self.new
       new_name.id = row[0]
       new_name.name = row[1]
       new_name.grade = row[2]
       new_name
    end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
