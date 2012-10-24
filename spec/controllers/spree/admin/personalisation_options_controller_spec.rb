require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Spree::Admin::PersonalisationOptionsController do

  # This should return the minimal set of attributes required to create a valid
  # Spree::PersonalisationOption. As you add validations to Spree::PersonalisationOption, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => 'option name', :presentation => 'Option Name', :variant_id => @product.master.id}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Spree::PersonalisationOptionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  before(:each) do
    @product = create(:product)
  end

  describe "GET index" do
    it "assigns all personalisation_options as @personalisation_options" do
      personalisation_option = Spree::PersonalisationOption.create! valid_attributes
      spree_get :index, {:product_id => @product.permalink}, valid_session
      assigns(:personalisation_options).should eq([personalisation_option])
    end
  end

  describe "GET new" do
    it "assigns a new personalisation_option as @personalisation_option" do
      spree_get :new, {:product_id => @product.permalink}, valid_session
      assigns(:personalisation_option).should be_a_new(Spree::PersonalisationOption)
    end
  end

  describe "GET edit" do
    it "assigns the requested personalisation_option as @personalisation_option" do
      personalisation_option = Spree::PersonalisationOption.create! valid_attributes
      spree_get :edit, {:product_id => @product.permalink, :id => personalisation_option.to_param}, valid_session
      assigns(:personalisation_option).should eq(personalisation_option)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Spree::PersonalisationOption" do
        expect {
          spree_post :create, {:product_id => @product.permalink, :personalisation_option => valid_attributes}, valid_session
        }.to change(Spree::PersonalisationOption, :count).by(1)
      end

      it "assigns a newly created personalisation_option as @personalisation_option" do
        spree_post :create, {:product_id => @product.permalink, :personalisation_option => valid_attributes}, valid_session
        assigns(:personalisation_option).should be_a(Spree::PersonalisationOption)
        assigns(:personalisation_option).should be_persisted
      end

      it "redirects to the created personalisation_option" do
        spree_post :create, {:product_id => @product.permalink, :personalisation_option => valid_attributes}, valid_session
        response.should redirect_to(spree.admin_product_personalisation_options_path(@product))
      end
    end

    describe "with invalid params" do
      # TODO fix this test or remove
      # it "assigns a newly created but unsaved personalisation_option as @personalisation_option" do
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Spree::PersonalisationOption.any_instance.stub(:save).and_return(false)
      #   spree_post :create, {:product_id => @product.permalink, :personalisation_option => {}}, valid_session
      #   assigns(:personalisation_option).should be_a_new(Spree::PersonalisationOption)
      # end

      # TODO fix this test or remove
      # it "re-renders the 'new' template" do
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Spree::PersonalisationOption.any_instance.stub(:save).and_return(false)
      #   spree_post :create, {:product_id => @product.permalink, :personalisation_option => {}}, valid_session
      #   response.should render_template("new")
      # end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      # TODO fix this test or remove
      # it "updates the requested personalisation_option" do
      #   personalisation_option = Spree::PersonalisationOption.create! valid_attributes
      #   # Assuming there are no other personalisation_options in the database, this
      #   # specifies that the Spree::PersonalisationOption created on the previous line
      #   # receives the :update_attributes message with whatever params are
      #   # submitted in the request.
      #   Spree::PersonalisationOption.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
      #   spree_put :update, {:product_id => @product.permalink, :id => personalisation_option.to_param, :personalisation_option => {'these' => 'params'}}, valid_session
      # end

      it "assigns the requested personalisation_option as @personalisation_option" do
        personalisation_option = Spree::PersonalisationOption.create! valid_attributes
        spree_put :update, {:product_id => @product.permalink, :id => personalisation_option.to_param, :personalisation_option => valid_attributes}, valid_session
        assigns(:personalisation_option).should eq(personalisation_option)
      end

      it "redirects to the personalisation_option" do
        personalisation_option = Spree::PersonalisationOption.create! valid_attributes
        spree_put :update, {:product_id => @product.permalink, :id => personalisation_option.to_param, :personalisation_option => valid_attributes}, valid_session
        response.should redirect_to(spree.admin_product_personalisation_options_path(@product))
      end
    end

    describe "with invalid params" do
      # TODO fix this test or remove
      # it "assigns the personalisation_option as @personalisation_option" do
      #   personalisation_option = Spree::PersonalisationOption.create! valid_attributes
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Spree::PersonalisationOption.any_instance.stub(:save).and_return(false)
      #   spree_put :update, {:product_id => @product.permalink, :id => personalisation_option.to_param, :personalisation_option => {}}, valid_session
      #   assigns(:personalisation_option).should eq(personalisation_option)
      # end

      # TODO fix this test or remove
      # it "re-renders the 'edit' template" do
      #   personalisation_option = Spree::PersonalisationOption.create! valid_attributes
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Spree::PersonalisationOption.any_instance.stub(:save).and_return(false)
      #   spree_put :update, {:product_id => @product.permalink, :id => personalisation_option.to_param, :personalisation_option => {}}, valid_session
      #   response.should render_template("edit")
      # end
    end
  end

  describe "DELETE destroy" do
      # TODO fix this test or remove
    # it "destroys the requested personalisation_option" do
    #   personalisation_option = Spree::PersonalisationOption.create! valid_attributes
    #   expect {
    #     spree_delete :destroy, {:product_id => @product.permalink, :id => personalisation_option.to_param}, valid_session
    #   }.to change(Spree::PersonalisationOption, :count).by(-1)
    # end

      # TODO fix this test or remove
    # it "redirects to the personalisation_options list" do
    #   personalisation_option = Spree::PersonalisationOption.create! valid_attributes
    #   spree_delete :destroy, {:product_id => @product.permalink, :id => personalisation_option.to_param}, valid_session
    #   response.should redirect_to(spree.admin_product_personalisation_options_path(@product))
    # end
  end

end