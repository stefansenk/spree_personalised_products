class CreateSpreePersonalisationDetails < ActiveRecord::Migration
  def change
    create_table :spree_personalisation_details do |t|
      t.string :name
      t.string :presentation
      t.string :value
      t.integer :line_item_id

      t.timestamps
    end
    add_index :spree_personalisation_details, :line_item_id
  end
end
