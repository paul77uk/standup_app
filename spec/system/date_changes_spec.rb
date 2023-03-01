require 'rails_helper'

RSpec.describe "DateChanges", type: :system do
  login_admin

  it "changes the date when the back arrow is pressed" do
    visit activity_mine_path

    click_on(id: 'date_backwards')

    expect(page).to have_content(
      (Date.today - 1.day)
      .strftime("%a, %b #{(Date.today - 1.day).day.ordinalize}")
    )
  end

  it "changes the date when the forwards arrow is pressed" do
    visit activity_mine_path

    click_on(id: 'date_forward')

    expect(page).to have_content(
      (Date.today + 1.day)
      .strftime("%a, %b #{(Date.today + 1.day).day.ordinalize}")
    )
  end

  it 'should be able to visit standups and move date from picker', js: true do
    visit activity_mine_path

    date = (Time.now + 1.day).strftime("%B %d, %Y")

    find('#datePicker').click
    # sleep 1
    # puts (find('body').native.attribute('outerHTML'))
    find(".flatpickr-calendar .flatpickr-day[aria-label='#{date}']").click

    expect(page).to have_content(
      (Time.now + 1.day)
      .strftime(
        "%a, %b #{(Time.now + 1.day).day.ordinalize}"
      )
    )
  end
end

# flatpickr-day[aria-label='April 28, 2022'
# flatpickr-day aria-label="April 28, 2022