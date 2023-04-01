FactoryBot.define do
  factory :user do
    account
    name { 'MyString' }
    email { Faker::Internet.email }
    password { '123ewq' }
    password_confirmation { '123ewq' }
  end
end
