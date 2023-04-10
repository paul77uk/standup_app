FactoryBot.define do
  factory :team do
    name { "MyString" }
    account
    timezone { "Arizona" }
    has_reminder { false }
    has_recap { false }
    reminder_time { "2022-04-23 00:12:32" }
    recap_time { "2022-04-23 00:12:32" }
  end
end
