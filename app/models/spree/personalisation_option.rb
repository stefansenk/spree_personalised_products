class Spree::PersonalisationOption < ActiveRecord::Base
  attr_accessible :max_length, :name, :presentation, :variant_id, :position

  belongs_to :variant, :touch => true #, :class_name => "Spree::Variant"
  
  default_scope :order => 'position ASC'

  validates :name, :presentation, :presence => true
  validates :max_length, :numericality => true, :allow_blank => true

end
