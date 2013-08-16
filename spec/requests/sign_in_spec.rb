require 'spec_helper'

describe "SignIns" do
  it "signs in users" do
    visit root_path
    click_link "Login"
    fill_in "Email", :with => "a@localhost.com"
    fill_in "Password", :with => "12345678"
    click_button "Login"
  end
end
