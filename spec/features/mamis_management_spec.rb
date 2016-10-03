require 'rails_helper'

describe "Mamis Management", type: :feature do
  let(:current_user){FactoryGirl.create(:user)}

  before(:each){ login(current_user) }

  context "creating new mamis" do

    before(:each){ visit new_mami_path }

    it "should be successfull" do
      fill_in "Nombre", with: "Lorraine Hynds"
      fill_in "Email", with: "ldhynds@gmail.com"
      click_button "Crear Mami"

      expect(current_path).to eq(mamis_path)
      expect(page).to have_content("Lorraine Hynds")
      expect(page).to have_content("ldhynds@gmail.com")
    end

    it "should be unsuccessfull" do
      fill_in "Nombre", with: "Mucup Raise"
      click_button "Crear Mami"
      expect(page).to have_css(".alert-danger")
    end
  end

  context "existing mamis" do
    let!(:mami){FactoryGirl.create(:mami, name: "Lorraine")}

    describe "edit" do
      it "has an edit option" do
        visit mamis_path
        click_link "Lorraine"
        expect(current_path).to eq(edit_mami_path(mami))
      end

      it "update the mami information" do
        visit edit_mami_path(mami)
        fill_in "Nombre", with: "Dathia"
        click_button "Actualizar"
        expect(current_path).to eq(mamis_path)
        expect(page).to have_content("Dathia")
      end

      it "fail with wrong information" do
        visit edit_mami_path(mami)
        fill_in "Nombre", with: nil
        click_button "Actualizar"
        expect(page).to have_css(".alert-danger")
      end

      it "delete a mami" do
        visit edit_mami_path(mami)
        click_link "Eliminar"
        expect(current_path).to eq(mamis_path)
        expect(page).to have_content("Se ha borrado la mami Lorraine")
      end
    end
  end
end
