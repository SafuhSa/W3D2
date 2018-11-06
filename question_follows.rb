require 'SQLite3'
require_relative 'QuestionsDatabase'

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
  
  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end