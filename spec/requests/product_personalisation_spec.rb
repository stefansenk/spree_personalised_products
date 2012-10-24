require 'spec_helper'

describe "Product page" do
  context "with personalisation options" do
    before(:each) do
      @product = create(:product, name: "Product1")
      create(:personalisation_option, :name => 'first name', :presentation => 'First Name', :max_length => 10, :position => 1, :variant => @product.master)
      create(:personalisation_option, :name => 'number', :presentation => 'Number', :max_length => 2, :position => 2, :variant => @product.master)
    end

    it "should display the personalisation options" do
      visit spree.root_path
      click_on "Product1"
      page.should have_content("Personalisation")
      within(:css, '#product_personalisation_options') { page.should have_content("First Name") }
      within(:css, '#product_personalisation_options') { page.should have_content("Number") }
    end

    it "should display variant personalisation options", :js => true do
      option_type = create(:option_type, :presentation => "Color")
      create(:product_option_type, :product => @product, :option_type => option_type)

      option_value1 = create(:option_value, :presentation => "Red", :option_type => option_type)
      variant1 = create(:variant, :product => @product, :option_values => [option_value1])
      create(:personalisation_option, :presentation => 'Red Personalisation', :variant => variant1)

      option_value2 = create(:option_value, :presentation => "Green", :option_type => option_type)
      variant2 = create(:variant, :product => @product, :option_values => [option_value2])
      create(:personalisation_option, :presentation => 'Green Personalisation', :variant => variant2)

      visit spree.root_path
      click_on "Product1"
      within(:css, '#product_personalisation_options') { page.should have_content("First Name") }
      within(:css, '#product_personalisation_options') { page.should have_content("Number") }

      choose "Color: Red"
      page.should have_css("#product_personalisation_options", :text => "Red Personalisation")
      page.should_not have_css("#product_personalisation_options", :text => "Green Personalisation")

      choose "Color: Green"
      page.should_not have_css("#product_personalisation_options", :text => "Red Personalisation")
      page.should have_css("#product_personalisation_options", :text => "Green Personalisation")
    end

    context "shopping cart" do
      before do
        visit spree.root_path
        click_on "Product1"
        fill_in "First Name", :with => "Katie"
        fill_in "Number", :with => "12"
        click_on "Add To Cart"
      end

      it "should display the personalisation" ,focus:true do
        current_path.should == "/cart"
        save_and_open_page
        page.should have_content("First Name: Katie")
        page.should have_content("Number: 12")
      end

      it "should allow updating the quantity"  do
        current_path.should == "/cart"
        find(:css, '.line_item_quantity').value.should == "1"
        fill_in 'order_line_items_attributes_0_quantity', with: 3
        click_on "Update"
        find(:css, '.line_item_quantity').value.should == "3"
        page.should have_content("First Name: Katie")
        page.should have_content("Number: 12")
      end

      it "shopping cart should allow a product multiple times with different personalisations" do
        visit spree.root_path
        click_on "Product1"
        fill_in "First Name", :with => "Adam"
        fill_in "Number", :with => "14"
        click_on "Add To Cart"
        current_path.should == "/cart"

        save_and_open_page
        within('tbody#line_items tr:nth-child(1)') do
          page.should have_content("Product1")
          page.should have_content("Katie")
          page.should have_content("12")
          find(:css, '.line_item_quantity').value.should == "1"
        end
        within('tbody#line_items tr:nth-child(2)') do
          page.should have_content("Product1")
          page.should have_content("Adam")
          page.should have_content("14")
          find(:css, '.line_item_quantity').value.should == "1"
        end
      end
    end

  end

  context "without personalisation options" do
    before(:each) do
      @product = create(:product, name: "Product2")
      visit spree.root_path
      click_on "Product2"
    end

    it "should not display any personalisation options" do
      page.should_not have_content("Personalisation")
    end
  end

end
