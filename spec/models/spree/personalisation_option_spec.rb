require 'spec_helper'

describe Spree::PersonalisationOption do
  let!(:personalisation_option) { create(:personalisation_option) }

  context "validations" do
    it "should validate presence of name" do
      personalisation_option.name = ""
      personalisation_option.should be_invalid
    end

    it "should validate presence of presentation" do
      personalisation_option.presentation = ""
      personalisation_option.should be_invalid
    end

    it "should validate max_length" do
      personalisation_option.max_length = 1
      personalisation_option.should be_valid
      personalisation_option.max_length = "a"
      personalisation_option.should be_invalid
      personalisation_option.max_length = nil
      personalisation_option.should be_valid
    end
  end

  context "parent product" do
    it "should be touched on updating the personalisation_option" do
      product = personalisation_option.variant.product
      updated_at = product.updated_at
      personalisation_option.save!
      product.reload.updated_at.should > updated_at
    end
  end

end

describe Spree::Variant do
  let!(:variant) { create(:variant) }

  context "no personalisation options" do
    it "should not have any personalisation options" do
      variant.has_personalisation_options?.should == false
    end
  end

  context "with personalisation options" do
    let!(:personalisation_option) { create(:personalisation_option, :variant_id => variant.id) }

    it "should have personalisation options" do
      variant.has_personalisation_options?.should == true
    end

    it "should have one personalisation option" do
      variant.personalisation_options.count.should == 1
      variant.all_personalisation_options.count.should == 1
    end

    it "should have one personalisation from the parant product" do
      create(:personalisation_option, :variant_id => variant.product.master.id)
      variant.personalisation_options.count.should == 1
      variant.all_personalisation_options.count.should == 2
    end
  end
end


describe Spree::Product do
  let!(:variant) { create(:variant) }
  let!(:product) { variant.product }

  context "no personalisation options" do
    it "product should have zero personalisation options" do
      product.variant_personalisation_options.count.should == 0
    end

    it "should not have any personalisation options" do
      product.has_personalisation_options?.should == false
    end
  end

  context "with personalisation options" do
    let!(:personalisation_option) { create(:personalisation_option, :variant_id => variant.id) }

    it "product should have 1 personalisation option" do
      product.variant_personalisation_options.count.should == 1
      product.personalisation_options.count.should == 0
    end

    it "product should have 1 personalisation option and 1 from the variant" do
      create(:personalisation_option, :variant_id => product.master.id)
      product.personalisation_options.count.should == 1
      product.variant_personalisation_options.count.should == 2
    end

    it "should not have personalisation options" do
      product.has_personalisation_options?.should == true
    end
  end
end



