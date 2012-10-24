module Spree
  module Admin
    class PersonalisationOptionsController < ResourceController
      before_filter :load_data

      # TODO
      # create.before :set_product
      # update.before :set_product
      # destroy.before :destroy_before

      def update_positions
        params[:positions].each do |id, index|
          PersonalisationOption.where(:id => id).update_all(:position => index)
        end

        respond_with(@personalisation_option) do |format|
          format.html { redirect_to admin_product_personalisation_options_url(params[:product_id]) }
          format.js  { render :text => 'Ok' }
        end
      end


      private

        def location_after_save
          admin_product_personalisation_options_url(@product)
        end

        def load_data
          @product = Product.where(:permalink => params[:product_id]).first
          @variants = @product.variants.collect do |variant|
            [variant.options_text, variant.id]
          end
          @variants.insert(0, [I18n.t(:all), @product.master.id])
        end

        # def set_product
        #   @personalisation_option.variant_id = params[:personalisation_option][:variant_id]
        #   # @image.viewable_type = 'Spree::Variant'
        #   # @image.viewable_id = params[:image][:viewable_id]
        # end

        # def destroy_before
        #   # @viewable = @image.viewable
        #   @product = @personalisation_option.variant.product
        # end

    end
  end
end
