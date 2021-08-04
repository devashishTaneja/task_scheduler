FactoryBot.define do
  factory :user do
    firstname {"John"}
    lastname {"Doe"}
    sequence :email do |n|
      "johndoe#{n}@gmail.com"
    end 
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end
