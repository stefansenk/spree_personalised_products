class CreateSpreePersonalisationOptions < ActiveRecord::Migration
  def change
    create_table :spree_personalisation_options do |t|
      t.string :name
      t.string :presentation
      t.integer :max_length
      t.integer :variant_id
      t.integer :position

      t.timestamps
    end

    add_index :spree_personalisation_options, :variant_id
  end
end
