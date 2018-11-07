require 'sqlite3'
require 'singleton'
class QuestionsDatabase < SQLite3::Database
include Singleton
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true
    end
end

class Model

end

class Questions 
  attr_accessor :title, :body, :author_id
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
   data.map { |datum| Questions.new(datum) }
 end
 def self.find_by_id(id)
   question = QuestionsDatabase.instance.execute(<<-SQL, id)
   SELECT 
    *
  FROM 
  questions
  WHERE 
  id = ?
  SQL
  Questions.new(question.first)
 end
 def initialize(options)
   @title = options['title']
   @body = options['body']
   @author_id = options['author_id']
 end
 
 def self.find_by_author(id)
   question = QuestionsDatabase.instance.execute(<<-SQL, id)
   SELECT 
    *
  FROM 
    questions
  WHERE 
    author_id = ?
  SQL
  Questions.new(question.first)
 end
 
 def author
   User.find_by_id(self.author_id)
 end
 def replies
   Replies.find_by_question_id(self.id)
end 

def followers
  
  # SELECT 
  #   * 
  #   FROM
  #   users
  #   JOIN 
  #   question_follows ON question_follows.user_id = users.id
  #     WHERE
  #     question_follows.question_id = self.id
  # 
  Question_follows.followers_for_question_id(self.id)
end



