class TaskMembership < ApplicationRecord
  belongs_to :task
  belongs_to :standup, touch: true
end
