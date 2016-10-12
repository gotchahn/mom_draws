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
      expect(page).to have_css(".alert-danger")
    end
  end

  context "existing events" do
    let!(:event){FactoryGirl.create(:event, name: "Bingotu", user: current_user)}

    describe "index" do
      it "display all recent events" do
        visit events_path
        within(".js-recents") do
          expect(page).to have_content("Bingotu")
        end
      end

      it "display completed events" do
        event.completed_at = Date.current
        event.save!
        visit events_path
        within(".js-events") do
          expect(page).to have_content("Bingotu")
          expect(page).to have_content("Completado")
        end
      end
    end

    describe "show" do
      it "display event information" do
        visit event_path(event)
        expect(page).to have_content("Bingotu")
        expect(page).to have_content("Lps. 5,000.00")
      end

      it "could be completed" do
        visit event_path(event)
        expect(page).to have_link("Completar")
      end

      it "could be edited" do
        visit event_path(event)
        click_link "Editar"
        expect(current_path).to eq(edit_event_path(event))
      end

      it "could not be completed or edited once completed" do
        event.completed_at = Date.current
        event.save!
        visit event_path(event)
        expect(page).not_to have_link("Completar")
        expect(page).not_to have_link("Editar")
        expect(page).not_to have_link("Agregar Donación")
      end
    end

    describe "edit" do
      it "update the event information" do
        visit edit_event_path(event)
        fill_in "Titulo", with: "Bingoyo"
        click_button "Actualizar"
        expect(current_path).to eq(event_path(event))
        expect(page).to have_content("Bingoyo")
      end

      it "fail with wrong information" do
        visit edit_event_path(event)
        fill_in "Titulo", with: nil
        click_button "Actualizar"
        expect(page).to have_css(".alert-danger")
      end

      it "delete an event without tickets sold" do
        visit edit_event_path(event)
        click_link "Eliminar"
        expect(current_path).to eq(events_path)
        expect(page).to have_content("Se ha borrado el evento Bingotu")
      end
    end

    context "sponsor donation" do
      let(:sponsor){ FactoryGirl.create(:sponsor, name: "Pepsi")}

      before(:each) do
        visit event_path(event)
        click_link "Agregar Donación"
      end

      it "add a donation from a sponsor" do
        select "Pepsi", from: "Patrocinador"
        fill_in "Descripcion", with: "Six Packs"
        fill_in "Monto", with: 3000
        click_button "Agregar Donacion"
        expect(current_path).to eq(event_path(event))
        within(".js-sponsor-donations") do
          expect(page).to have_content("Pepsi")
          expect(page).to have_content("Six Packs")
        end
      end

      it "fail for wrong donation info" do
        select "Pepsi", from: "Patrocinador"
        click_button "Agregar Donacion"
        expect(page).to have_css(".alert-danger")
      end
    end
  end
end
