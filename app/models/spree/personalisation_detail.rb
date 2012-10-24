class Spree::PersonalisationDetail < ActiveRecord::Base
  attr_accessible :name, :presentation, :value, :line_item_id

  belongs_to :line_item

  validates :name, :presentation, :line_item_id, :presence => true
end
