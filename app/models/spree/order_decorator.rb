
module Spree
  LineItem.class_eval do
    has_many :personalisation_details, :dependent => :destroy

    def has_personalisation_details?
      personalisation_details.any?
    end
  end
end


module Spree
  OrdersController.class_eval do

    # Adds a new item to the order (creating a new order if none already exists)
    #
    # Parameters can be passed using the following possible parameter configurations:
    #
    # * Single variant/quantity pairing
    # +:variants => {variant_id => quantity}+
    #
    # * Multiple products at once
    # +:products => {product_id => variant_id, product_id => variant_id}, :quantity => quantity +
    # +:products => {product_id => variant_id, product_id => variant_id}}, :quantity => {variant_id => quantity, variant_id => quantity}+

    # :personalisation_options => {personalisation_option_id => value, personalisation_option_id => value, ...}

    def populate
      @order = current_order(true)

      params[:products].each do |product_id,variant_id|
        quantity = params[:quantity].to_i if !params[:quantity].is_a?(Hash)
        quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Hash)
        @order.add_variant_with_personalisation(Variant.find(variant_id), quantity, params[:personalisation_options] ) if quantity > 0
      end if params[:products]

      params[:variants].each do |variant_id, quantity|
        quantity = quantity.to_i
        @order.add_variant_with_personalisation(Variant.find(variant_id), quantity, params[:personalisation_options]) if quantity > 0
      end if params[:variants]

      fire_event('spree.cart.add')
      fire_event('spree.order.contents_changed')
      respond_with(@order) { |format| format.html { redirect_to cart_path } }
    end

  end
end

module Spree
  Order.class_eval do

    def add_variant_with_personalisation(variant, quantity = 1, personalisation = {})

      current_item = contains?(variant)
      # current_item = find_line_item_by_variant(variant) # TODO used in Spree 1.2

      if current_item and personalisation.blank?
        current_item.quantity += quantity
        current_item.save
      else
        current_item = LineItem.new(:quantity => quantity)
        current_item.variant = variant
        current_item.price   = variant.price
        self.line_items << current_item
      end

      if !personalisation.blank? and variant.has_personalisation_options?
        personalisation.each do |personalisation_option_id, value|
          personalisation_option = PersonalisationOption.find(personalisation_option_id)
          personalisation_detail = PersonalisationDetail.new({
            :value => value,
            :name => personalisation_option.name,
            :presentation => personalisation_option.presentation,
          })
          current_item.personalisation_details << personalisation_detail
        end
      end

      # TODO remove for Spree 1.2
      # populate line_items attributes for additional_fields entries
      # that have populate => [:line_item]
      Variant.additional_fields.select { |f| !f[:populate].nil? && f[:populate].include?(:line_item) }.each do |field|
        value = ''

        if field[:only].nil? || field[:only].include?(:variant)
          value = variant.send(field[:name].gsub(' ', '_').downcase)
        elsif field[:only].include?(:product)
          value = variant.product.send(field[:name].gsub(' ', '_').downcase)
        end
        current_item.update_attribute(field[:name].gsub(' ', '_').downcase, value)
      end

      self.reload
      current_item
    end

  end
end

