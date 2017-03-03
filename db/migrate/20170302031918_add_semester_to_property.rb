class AddSemesterToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :semester, :string
  end
end
