require "rails_helper"

RSpec.feature "a valid admin" do
  let(:admin) { User.create(email: "example@example.com", password: "password", full_name: "example", display_name: "example admin", role: 1) }

  def admin_log_in
    admin
    visit "/login"
    fill_in("session[email]", with: admin.email)
    fill_in("session[password]", with: admin.password)
    click_link_or_button "Login"
  end

  xcontext "views the admin categories dashboard" do
    scenario "can see all of the categories" do
      cat1 = Category.create(title: "Food", description: "food_description")
      cat2 = Category.create(title: "Drinks", description: "drink_description")
      admin_log_in
      click_link_or_button "Manage Categories"
      expect(page).to have_content("Food Drinks")
    end

    scenario "can add a new category" do
      admin_log_in
      click_link_or_button "Manage Categories"
      click_link_or_button "Add New Category"
      fill_in("category[title]", with: "Food")
      fill_in("category[description]", with: "A new description")
      click_link_or_button "Create Category"
      expect(page).to have_content("Food")
    end
  end
end
