class CreateDaysOfTheWeekMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :days_of_the_week_memberships, id: :uuid do |t|
      t.references :team, null: false, foreign_key: true, type: :uuid
      t.integer :day

      t.timestamps
    end
  end
end
