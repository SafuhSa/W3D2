require 'SQLite3'
require_relative 'QuestionsDatabase'
require_relative 'UsersDatabase'

class Question_follows
  attr_accessor :question_id, :user_id
  
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    data.map { |question| Question_follows.new(question) }
  end
  
  def self.find_by_id(id)
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      id = ?
    SQL
    
    Question_follows.new(q_follow.first)
  end
  
  def self.followers_for_question_id(question_id)
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users
    Join question_follows ON Users.id = question_follows.user_id
    WHERE
      question_follows.question_id = ?
    SQL
    q_follow.map { |user| Users.new(user) }
  end

    def self.followed_questions_for_user_id(user_id)
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      Question
    Join question_follows ON questions.id = question_follows.question_id
    WHERE
      question_follows.user_id = ?
    SQL
      q_follow.map { |question| Questions.new(question) }
  end
  
  def most_followed_question(n)
    q_follow =  QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT 
      question_id,count(user_id)
    FROM
      question_follows
    GROUP BY 
      question_id
    ORDER BY DESC LIMIT  ?
      SQL
      q_follow
  end
  
  
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  
end