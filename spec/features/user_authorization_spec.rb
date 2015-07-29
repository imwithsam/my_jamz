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
  
  scenario "Non-admin cannot view all users" do
    user = User.create(username: "default", password: "password", role: 0)

    # stub current_user to return user whenever called
    # using rspec-mocks
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_users_path

    expect(page).to_not have_content("All Users")
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
