module LoginHelper
  def login(current_user)
    visit login_path
    fill_in "session_email", with: current_user.email
    fill_in "session_password", with: current_user.password
    click_button "Login"
  end
end
