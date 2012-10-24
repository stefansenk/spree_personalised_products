require 'factory_girl'

FactoryGirl.define do
  factory :personalisation_option, :class => Spree::PersonalisationOption do
    name "personalisation_option"
    presentation "Personalisation Option"
    max_length 10
    variant { |r| Spree::Variant.where(is_master: true).find(:first) || r.association(:variant) }
    # association(:variant, :factory => :variant)
    position 1
  end
end
