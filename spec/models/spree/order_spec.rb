require 'spec_helper'

describe Spree::Order do

  context "#add_variant_with_personalisation" do
    before do
      @product = create(:product, :price => 22.25)
      @order = create(:order)
    end

    it "should update order totals" do
      @order.item_total.to_f.should == 0.00
      @order.total.to_f.should == 0.00

      @order.add_variant_with_personalisation(@product.master)

      @order.item_total.to_f.should == 22.25
      @order.total.to_f.should == 22.25
    end

    it "should create the personalisation details" do
      option1 = create(:personalisation_option, :name => 'first name', :variant => @product.master)
      option2 = create(:personalisation_option, :name => 'number', :variant => @product.master)

      @order.add_variant_with_personalisation(@product.master, 1, {option1.id => "James", option2.id => "21"})

      details = @order.line_items.first.personalisation_details
      details.find_by_name('number').value.should == "21"
      details.find_by_name('first name').value.should == "James"
    end

  end

end



