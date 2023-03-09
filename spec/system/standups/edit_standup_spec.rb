require 'rails_helper'

RSpec.describe "standup/edit", type: :system do
  login_admin

  context 'show a edit standup' do

    it 'on the activity#mine page when record is updated', js: true do
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit activity_mine_path
      expect(page).to have_css('.w-96')
      expect(page).to have_content(Date.today.iso8601)
      check_turbo_and_sleep

      standup.update(standup_date: Date.tomorrow.iso8601)

      expect(page).to have_css('.w-96')
      expect(page).to have_content(Date.tomorrow.iso8601)
    end

    it 'on the teams#show page when record is updated', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit team_path(team)
      
      expect(page).to have_content('Dids')
      check_turbo_and_sleep

      standup.dids << Did.new(title: 'Hello there')

      expect(page).to have_css('.w-96')
      expect(page).to have_content('Hello there')
    end

    it 'on the teams/standups#index page when record is updated', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit team_standups_path(team)
      
      expect(page).to have_content('Dids')
      check_turbo_and_sleep

      standup.dids << Did.new(title: 'Hello there')

      expect(page).to have_css('.w-96')
      expect(page).to have_content('Hello there')
    end
  end
end