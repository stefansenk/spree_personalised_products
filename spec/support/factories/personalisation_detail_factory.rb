require 'factory_girl'

FactoryGirl.define do
  factory :personalisation_detail, :class => Spree::PersonalisationDetail do
    name "personalisation_detail"
    presentation "Personalisation Detail"
    value "some value"
    line_item nil
  end
end

