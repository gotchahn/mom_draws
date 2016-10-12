require 'rails_helper'

describe "Patrocinadores Management", type: :feature do
  let(:current_user){FactoryGirl.create(:user)}

  before(:each){ login(current_user) }

  context "creating new sponsors" do

    before(:each){ visit new_sponsor_path }

    it "should be successfull" do
      fill_in "Nombre", with: "Lorraine Hynds"
      fill_in "Email", with: "ldhynds@gmail.com"
      click_button "Crear Patrocinador"

      expect(current_path).to eq(sponsors_path)
      expect(page).to have_content("Lorraine Hynds")
      expect(page).to have_content("ldhynds@gmail.com")
    end

    it "should be unsuccessfull" do
      fill_in "Nombre", with: "Mucup Raise"
      click_button "Crear Patrocinador"
      expect(page).to have_css(".alert-danger")
    end
  end

  context "existing sponsors" do
    let!(:sponsor){FactoryGirl.create(:sponsor, name: "Lorraine")}

    describe "show" do
      it "display sponsor information" do
        visit sponsor_path(sponsor)
        expect(page).to have_content("Lorraine")
        expect(page).to have_content(sponsor.email)
        expect(page).to have_content(sponsor.phone)
      end

      it "display the donations made" do
        donation = sponsor.sponsor_donations.create(event: FactoryGirl.create(:event), description: "Cupcakes by HD", amount: 10)
        visit sponsor_path(sponsor)
        expect(page).to have_content(donation.description)
        expect(page).to have_content(donation.event.name)
      end
    end

    describe "edit" do

      it "has an edit option" do
        visit sponsor_path(sponsor)
        click_link "Editar"
        expect(current_path).to eq(edit_sponsor_path(sponsor))
      end

      it "update the sponsor information" do
        visit edit_sponsor_path(sponsor)
        fill_in "Nombre", with: "Dathia"
        click_button "Actualizar"
        expect(current_path).to eq(sponsors_path)
        expect(page).to have_content("Dathia")
      end

      it "fail with wrong information" do
        visit edit_sponsor_path(sponsor)
        fill_in "Nombre", with: nil
        click_button "Actualizar"
        expect(page).to have_css(".alert-danger")
      end

      it "delete a sponsor" do
        visit edit_sponsor_path(sponsor)
        click_link "Eliminar"
        expect(current_path).to eq(sponsors_path)
        expect(page).to have_content("Se ha borrado Lorraine")
      end
    end
  end
end
