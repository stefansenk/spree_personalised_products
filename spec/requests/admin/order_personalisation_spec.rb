require 'spec_helper'

describe "Order Personalisation" do
  context "as admin user" do
    let!(:product) { create(:product, :name => 'spree t-shirt', :on_hand => 5, :price => 19.99) }
    let!(:order) { create(:completed_order_with_totals) }
    let!(:line_item) { order.line_items << create(:line_item); order.line_items.last }

    before(:each) do
      create(:personalisation_detail, :presentation => 'First Name', :value => 'Joe', :line_item_id => line_item.id)
      create(:personalisation_detail, :presentation => 'Second Name', :value => 'Bloggs', :line_item_id => line_item.id)

      sign_in_as!(create(:admin_user))
      visit spree.admin_path
      click_link "Orders"
      within(:css, 'table#listing_orders') { click_link "Edit" }
    end

    it "should display the personalisation details" do
      page.should have_content "First Name"
      page.should have_content "Joe"
      page.should have_content "Second Name"
      page.should have_content "Bloggs"
    end

    it "should allow editing personalisation details" do
      pending "Needs implementation"
    end

  end
end
