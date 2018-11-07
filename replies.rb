require 'SQLite3'
require_relative 'QuestionsDatabase'

class Replies
  attr_accessor :question_id, :parent_id, :author_id, :body, :id
  
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    data.map { |question| Replies.new(question) }
  end
  
  def self.find_by_id
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    
    Replies.new(q_follow.first)
  end
  
  def self.find_by_user
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, self.author_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    
    Replies.new(q_follow.first)
  end
  def self.find_by_question_id
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, self.question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    
    Replies.new(q_follow.first)
  end
  
  
  def initialize(options)
    @question_id = options['question_id']
    @author_id = options['author_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end
  
  def author
    User.find_by_id(self.author_id)
  end
  
  def question
    Question.find_by_id(self.question_id)
  end
  def parent_replay
    User.find_by_id(self.parent_id)
  end
  
  def child_replies
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, self.parent_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    
    Replies.new(q_follow.first)  
  end
end
class Question_likes
  attr_accessor :question_id, :user_id, :likes
  
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    data.map { |question| Question_likes.new(question) }
  end
  
  def self.find_by_id(id)
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL
    
    Question_likes.new(q_follow.first)
  end
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
    @likes = options['likes']
  end
end
