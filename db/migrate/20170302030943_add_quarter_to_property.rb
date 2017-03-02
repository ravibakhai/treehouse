class AddQuarterToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :quarter, :string
  end
end
