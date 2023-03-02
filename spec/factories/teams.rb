FactoryBot.define do
  factory :team do
    name { "MyString" }
    account
    timezone { "Arizona" }
    has_reminder { false }
    has_recap { false }
    reminder_time { "2023-03-01 13:01:01" }
    recap_time { "2023-03-01 13:01:01" }
  end
end
