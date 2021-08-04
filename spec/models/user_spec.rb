require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'should have a firstname' do
    user = build(:user, firstname: nil)
    expect(user).not_to be_valid
  end

  it 'should have a lastname' do
    user = build(:user, lastname: nil)
    expect(user).not_to be_valid
  end

  it 'should have an email address' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'should have a valid email address' do
    user = build(:user, email: 'abcd')
    expect(user).not_to be_valid
  end

  it 'should not have duplicate email id' do
    create(:user, email: 'sample@example.com')
    user = build(:user, email: 'sample@example.com')
    expect(user).not_to be_valid
  end

  it 'should have non-empty password' do
    user = build(:user, password: "", password_confirmation: "")
    expect(user).not_to be_valid
  end

  it 'should have password equal to password confimation' do
    user = build(:user, password_confirmation: "Something Different")
    expect(user).not_to be_valid
  end


  it 'should return the full name of user' do
    user = build(:user)
    expect(user.name).to eq('John Doe')
  end

  it 'should change eamil to lower case before saving' do
    user = create(:user, email: 'Sample@gmail.com')
    expect(user.email).to eq('sample@gmail.com')
  end
end