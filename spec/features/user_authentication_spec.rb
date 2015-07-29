require "rails_helper"
require "capybara/rails"
require "capybara/rspec"

RSpec.feature "User authentication", type: :feature do
  scenario "User can create an account" do
    visit new_user_path

    fill_in "Username", with: "Sam"
    fill_in "Password", with: "jamz"
    click_button "Create Account"
    
    expect(page).to have_content("Welcome to MyJamz, Sam!")
  end

  scenario "User can log in to their account" do
    User.create(username: "Sam", password: "jamz")

    visit login_path

    fill_in "Username", with: "Sam"
    fill_in "Password", with: "jamz"
    click_button "Login"

    expect(page).to have_content("You are now logged in, Sam.")
    # expect(page).to have_link("Logout")
  end

  scenario "User can log out of their account" do
    User.create(username: "Sam", password: "jamz")

    visit login_path

    fill_in "Username", with: "Sam"
    fill_in "Password", with: "jamz"
    click_button "Login"
    click_link "Logout"

    expect(page).to have_content("You are now logged out.")
    expect(page).to have_link("Sign In")
  end
end
