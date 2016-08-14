class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property_type
      t.string :string
      t.integer :room
      t.string :accommodate
      t.string :integer
      t.integer :bedroom
      t.integer :bathroom
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_tv
      t.boolean :is_kitchen
      t.boolean :is_ac
      t.boolean :is_heating
      t.boolean :is_internet
      t.boolean :is_furnished
      t.boolean :is_workspace
      t.boolean :is_dishwasher
      t.boolean :is_pet_allowed
      t.boolean :is_parking
      t.boolean :is_doorman
      t.boolean :is_roof_access
      t.boolean :is_gym
      t.boolean :is_pool
      t.integer :price
      t.integer :square_foot
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
