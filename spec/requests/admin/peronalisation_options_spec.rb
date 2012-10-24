require 'spec_helper'

describe "Personalisation Option" do
  context "as admin user" do
    before(:each) do
      visit spree.admin_path
    end

    context "creating a new personalisation_option" do
      before(:each) do
        create(:product)
        click_link 'Products'
        within('table.index tr:nth-child(2)') { click_link "Edit" }
        click_link 'Personalisation Options'
        click_link "New Personalisation Option"
      end

      it "should allow creating a new personalisation_option", :js => true do
        fill_in "personalisation_option_name", :with => "myoption"
        fill_in "personalisation_option_presentation", :with => "My Option"
        fill_in "personalisation_option_max_length", :with => "4"
        click_button "Create"
        page.should have_content("successfully created")
        within('table.index') { page.should have_content("My Option") }
        within('table.index') { page.should have_content("4") }
        within('table.index') { page.should have_content("All") }
      end

      it "should show validation errors", :js => true do
        click_button "Create"
        page.should have_content("Name can't be blank")
        page.should have_content("Presentation can't be blank")
      end
    end

    context "with personalisation_options" do
      before do
        create(:product)
        create(:personalisation_option, :name => 'first name', :presentation => 'First Name', :max_length => 10, :position => 1)
        create(:personalisation_option, :name => 'number', :presentation => 'Number', :max_length => 2, :position => 3)
        create(:personalisation_option, :name => 'second name', :presentation => 'Second Name', :max_length => 8, :position => 2)

        click_link 'Products'
        within('table.index tr:nth-child(2)') { click_link "Edit" }
        click_link 'Personalisation Options'
      end

      it "should list existing personalisation_options with correct sorting by position" do
        within('table.index tr:nth-child(2)') { page.should have_content("First Name") }
        within('table.index tr:nth-child(2)') { page.should have_content("10") }

        within('table.index tr:nth-child(3)') { page.should have_content("Second Name") }
        within('table.index tr:nth-child(3)') { page.should have_content("8") }

        within('table.index tr:nth-child(4)') { page.should have_content("Number") }
        within('table.index tr:nth-child(4)') { page.should have_content("2") }
      end

      it "should allow editing an existing personalisation_option" do
        within('table.index tr:nth-child(3)') { click_link "Edit" }
        fill_in "personalisation_option_name", :with => "A new name"
        fill_in "personalisation_option_presentation", :with => "A New Name"
        select "All", :from => "personalisation_option_variant_id"
        fill_in "personalisation_option_max_length", :with => 4
        click_button "Update"
        page.should have_content "successfully updated"
        within('table.index tr:nth-child(3)') { page.should have_content("A New Name") }
        within('table.index tr:nth-child(3)') { page.should have_content("4") }
        within('table.index tr:nth-child(3)') { page.should have_content("All") }
      end

      it "should allow re-ordering personalisation options" do
        #, :js => true
        pending "Work out how to test this"

        item = page.find('table.index tr:nth-child(2) .handle') # TODO get drag object
        target = page.find('table.index tr:nth-child(4)') # TODO get drag target
        item.drag_to target # TODO do the drag
        click_link 'Personalisation Options'
        within('table.index tr:nth-child(2)') { page.should have_content("Second Name") }
        within('table.index tr:nth-child(3)') { page.should have_content("Number") }
        within('table.index tr:nth-child(4)') { page.should have_content("First Name") }
      end


      it "should allow deleting a personalisation option" do
        #, :js => true
        pending "Work out how to test this"

        within('table.index tr:nth-child(2)') { click_link "Delete" }
        # TODO click OK in dialog window
        page.should have_content("successfully removed")
        click_link 'Personalisation Options'
        page.should_not have_content("Second Name")
      end
    end

    context "with variants" do

      before do
        option_type = create(:option_type, :presentation => "Color")
        option_value = create(:option_value, :presentation => "Red", :option_type => option_type)
        product = create(:product)
        create(:product_option_type, :product => product, :option_type => option_type)
        variant = create(:variant, :product => product, :option_values => [option_value])
        create(:personalisation_option, :name => 'first name', :position => 1, :variant => product.master)
        create(:personalisation_option, :name => 'number', :position => 2, :variant => variant)

        click_link 'Products'
        within('table.index tr:nth-child(2)') { click_link "Edit" }
        click_link 'Personalisation Options'
      end

      it "should list personalisation_options with variant populated" do
        within('table.index tr:nth-child(2)') { page.should have_content("first name") }
        within('table.index tr:nth-child(2)') { page.should have_content("All") }
        within('table.index tr:nth-child(3)') { page.should have_content("number") }
        within('table.index tr:nth-child(3)') { page.should have_content("Color: Red") }
      end

      it "should allow updating the variant on a personalisation option" do
        within('table.index tr:nth-child(2)') { click_link "Edit" }
        select "Color: Red", :from => "personalisation_option_variant_id"
        click_button "Update"
        page.should have_content "successfully updated"
        within('table.index tr:nth-child(2)') { page.should have_content("Color: Red") }
        within('table.index tr:nth-child(3)') { page.should have_content("Color: Red") }

        within('table.index tr:nth-child(3)') { click_link "Edit" }
        select "All", :from => "personalisation_option_variant_id"
        click_button "Update"
        page.should have_content "successfully updated"
        within('table.index tr:nth-child(2)') { page.should have_content("All") }
        within('table.index tr:nth-child(2)') { page.should have_content("number") }
        within('table.index tr:nth-child(3)') { page.should have_content("Color: Red") }
      end

    end

  end
end
