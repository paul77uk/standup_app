require 'rails_helper'

RSpec.describe "standup/new", type: :system do
  login_admin

  context 'show a new standup' do

    it 'on the activity#mine page when record is created', js: true do
      visit activity_mine_path
      expect(page).to have_no_css('.w-96')
      check_turbo_and_sleep

      FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      expect(page).to have_css('.w-96')
    end

    it 'on the teams#show page when record is created', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      visit team_path(team)
      
      expect(page).to have_no_content('Dids')
      check_turbo_and_sleep

      FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      expect(page).to have_content(@admin.name)
    end

    it 'on the teams/standups#index page when record is created', js: true do
      team = FactoryBot.create(:team)
      team.users << @admin
      visit team_standups_path(team)
      
      expect(page).to have_no_content('Dids')
      check_turbo_and_sleep

      FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      expect(page).to have_content(@admin.name)
    end

    it 'in the nortifications dropdown', js: true do
      visit activity_mine_path
      expect(page).to have_no_css('.w-96')
      click_button(id: 'notification_dropdown')
      expect(page).to have_content('0 Notifications')
      check_turbo_and_sleep

      FactoryBot.create(:standup, standup_date: Date.today, user_id: @admin.id)

      expect(page).to have_css('.w-96')
      expect(page).to have_content('1 Notifications')
      expect(page).to have_content("#{@admin.name} has a new Standup from #{Date.today.iso8601}")
    end
  end
end
