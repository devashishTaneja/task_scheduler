require 'rails_helper'

RSpec.describe Task, type: :model do
	it 'should have a valid factory' do
		expect(build(:task)).to be_valid
	end

	it 'should have a title' do
		task = build(:task, title: nil)
		expect(task).not_to be_valid
	end

	it 'should have some body' do
		task = build(:task, body: nil)
		expect(task).not_to be_valid
	end

	it 'should have a maximum 200 characters in body' do
		task = build(:task, body: 'x'*201)
		expect(task).not_to be_valid
	end


	it 'should have a valid expiry date' do
		task = build(:task, expires_on: nil)
		expect(task).not_to be_valid
  end

	it 'should have the expiry date in future' do
		task = build(:task, expires_on: Time.now-1000)
		expect(task).not_to be_valid
	end

  it 'should have a belong_to association with user' do
    expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'should belong to a user' do
    task = build(:task)
		expect(task.user).not_to be_nil
  end

  it 'can be reassigned to another user' do
    user1 = build(:user, firstname:"John", lastname:"Doe")
    task = build(:task, user: user1)
    expect(task.user).to eq(user1)
    user2 = build(:user, firstname:"Devashish", lastname:"Taneja")
    task.user = user2
    expect(task.user).to eq(user2)
  end

end
