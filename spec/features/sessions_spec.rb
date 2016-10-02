require 'rails_helper'

describe "Session Management", type: :feature do
  let!(:current_user) { FactoryGirl.create(:user) }

  it "redirects to events page on successful login" do
    login(current_user)
    expect(current_path).to eq(events_path)
  end

  it "has an error state for unrecognized credentials" do
    visit login_path
    expect(page).not_to have_css('.alert-danger')

    fill_in "session_email", with: "hola"
    fill_in "session_password", with: "mucup"
    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_css('.alert-danger')
  end

  it "redirects to originally requested secured page after login" do
    visit events_path
    expect(current_path).to eq(login_path)
  end

  it "redirects to events page if already logged in" do
    login(current_user)
    visit login_path
    expect(current_path).to eq(events_path)
  end

  it "signs users out" do
    login(current_user)
    visit events_path
    click_link "Cerrar Sesión"
    expect(current_path).to eq(root_path)
  end
end
