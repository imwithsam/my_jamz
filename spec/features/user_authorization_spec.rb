require "rails_helper"
require "capybara/rails"
require "capybara/rspec"

RSpec.feature "User authorization", type: :feature do
  scenario "Admin can view all users" do
    admin = User.create(username: "admin", password: "password", role: 1)

    # stub current_user to return admin whenever called
    # using rspec-mocks
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_users_path

    expect(page).to have_content("All Users")
  end
end
