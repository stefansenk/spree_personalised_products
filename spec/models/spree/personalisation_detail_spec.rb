require 'spec_helper'

describe Spree::PersonalisationDetail do
  let!(:order) { create(:order) }
  let!(:line_item) { order.line_items << create(:line_item); order.line_items.last }
  let!(:personalisation_detail) { create(:personalisation_detail, :line_item_id => line_item.id) }

  context "validations" do
    it "should validate presence of name" do
      personalisation_detail.name = ""
      personalisation_detail.should be_invalid
    end

    it "should validate presence of presentation" do
      personalisation_detail.presentation = ""
      personalisation_detail.should be_invalid
    end

    it "should validate presence of line_item" do
      personalisation_detail.line_item = nil
      personalisation_detail.should be_invalid
    end

    it "should be destroyed when line item is" do
      personalisation_detail.line_item.destroy
      lambda { personalisation_detail.reload }.should raise_error
    end
  end

end

describe Spree::LineItem do
  let!(:order) { create(:order) }
  let!(:line_item) { order.line_items << create(:line_item); order.line_items.last  }

  context "no personalisation details" do
    it "should not have any personalisation options" do
      line_item.has_personalisation_details?.should == false
    end
  end

  context "with personalisation details" do
    let!(:personalisation_detail) { create(:personalisation_detail, :presentation => 'aa', :value => 'bbb', :line_item_id => line_item.id) }

    it "should have personalisation options" do
      line_item.has_personalisation_details?.should == true
    end
  end
end



