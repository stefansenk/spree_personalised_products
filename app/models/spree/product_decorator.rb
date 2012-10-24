Spree::Product.class_eval do
  delegate_belongs_to :master, :personalisation_options
  has_many :variant_personalisation_options, :source => :personalisation_options, :through => :variants_including_master

  def has_personalisation_options?
    variant_personalisation_options.any?
  end
end

Spree::Variant.class_eval do
  has_many :personalisation_options, :dependent => :destroy

  def has_personalisation_options?
    all_personalisation_options.any?
  end

  def all_personalisation_options
    Spree::PersonalisationOption.where(variant_id: [product.master, self]) 
  end
end
