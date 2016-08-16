class AddWasherToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :washer, :string
  end
end
