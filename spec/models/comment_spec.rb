require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:valid_comment) do
    user = create(:user)
    task = create(:task)
    Comment.new('Sample Content', task, user)
  end

  it 'should have a valid factory' do
    expect(valid_comment).to be_valid
  end
  
  it 'should belong to a user' do
    valid_comment.user_id = nil
    expect(valid_comment).not_to be_valid
  end

  it 'should belong to a task' do
    valid_comment.task_id = nil
    expect(valid_comment).not_to be_valid
  end

  it 'should have non empty content' do
    valid_comment.content = ''
    expect(valid_comment).not_to be_valid
  end
end
