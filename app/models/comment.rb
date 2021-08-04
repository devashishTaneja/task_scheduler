class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  field :user_id, type: Integer
  field :task_id, type: Integer
  
  def initialize(content, task, user)
    super()
    self.content = content
    self.task_id = task.id
    self.user_id = user.id
  end

  validates_presence_of :content, :user_id, :task_id

end