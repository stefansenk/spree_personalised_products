require 'spec_helper'

describe "Order Personalisation" do
  context "as admin user" do
    let!(:order) { create(:order, :completed_at => "2011-02-01 12:36:15", :number => "R100") }
    let!(:product) { create(:product, :name => 'spree t-shirt', :on_hand => 5, :price => 19.99) }
    let!(:line_item) { order.line_items << create(:line_item); order.line_items.last }

    before(:each) do
      create(:personalisation_detail, :presentation => 'First Name', :value => 'Joe', :line_item_id => line_item.id)
      create(:personalisation_detail, :presentation => 'Second Name', :value => 'Bloggs', :line_item_id => line_item.id)

      sign_in_as!(create(:admin_user))
      visit spree.admin_path
      click_link "Orders"
    end

    it "should display the personalisation details" do
      within_row(1) { click_link "R100" }
      page.should have_content "First Name"
      page.should have_content "Joe"
      page.should have_content "Second Name"
      page.should have_content "Bloggs"
    end

    it "should display multiple personalisation details" do
      line_item2 = create(:line_item)
      order.line_items << line_item2
      create(:personalisation_detail, :presentation => 'First Name', :value => 'Jane', :line_item_id => line_item2.id)
      within_row(1) { click_link "R100" }
      page.should have_content "Joe"
      page.should have_content "Jane"
    end

    it "should allow editing personalisation details" do
      pending "Needs implementation"
    end

  end
end
