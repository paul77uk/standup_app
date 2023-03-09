require 'rails_helper'

RSpec.describe "standup/destroy", type: :system do
  login_admin

  context 'show a destroyed standup' do

    it 'on the activity#mine page when record is destroyed', js: true do
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit activity_mine_path
      expect(page).to have_css('.w-96')
      expect(page).to have_content(Date.today.iso8601)
      check_turbo_and_sleep

      standup.destroy

      expect(page).to have_no_css('.w-96')
      expect(page).to have_no_content(Date.tomorrow.iso8601)
    end

    it 'on the teams#show page when record is destroyed', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit team_path(team)
      
      expect(page).to have_content('Dids')
      check_turbo_and_sleep

      standup.destroy

      expect(page).to have_no_content('Dids')
    end

    it 'on the teams/standups#index page when record is destroyed', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit team_standups_path(team)
      
      expect(page).to have_content('Dids')
      check_turbo_and_sleep

      standup.destroy

      expect(page).to have_no_content('Dids')
    end

    it 'in the nortifications dropdown', js: true do
      standup = FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      visit activity_mine_path
      expect(page).to have_css('.w-96')
      click_button(id: 'notification_dropdown')
      expect(page).to have_content('1 Notifications')
      expect(page).to have_content("#{@admin.name} has a new Standup from #{Date.today.iso8601}")
      check_turbo_and_sleep

      standup.destroy

      expect(page).to have_no_css('.w-96')
      expect(page).to have_content('0 Notifications')
    end
  end
end
