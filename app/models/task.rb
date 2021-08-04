class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum:200 }
  validate :expiration_date_to_be_in_the_future
  validates :expires_on, presence: true
  scope :active_tasks, -> { where("expires_on >= ?", Date.today) }
  scope :expired_task, -> { where("expires_on < ?", Date.today) }
  
  def expiration_date_to_be_in_the_future
    if expires_on && expires_on < Time.now
      errors.add(:expires_on,"Cannot be in the past")
    end
  end

  def comments
    Comment.where(task_id:self.id)
  end

end