require 'rails_helper'

describe "Events Management", type: :feature do
  let(:current_user){FactoryGirl.create(:user)}

  before(:each){ login(current_user) }

  context "creating new events" do

    before(:each){ visit new_event_path }

    it "should be successfull" do
      fill_in "Titulo", with: "Mucup Raise"
      fill_in "Meta", with: "50000"
      fill_in "Precio por Ticket", with: "150"
      click_button "Crear Evento"

      expect(current_path).to eq(events_path)
      expect(page).to have_content("Mucup Raise")
    end

    it "should be unsuccessfull" do
      fill_in "Titulo", with: "Mucup Raise"
      click_button "Crear Evento"
    end
  end

end
