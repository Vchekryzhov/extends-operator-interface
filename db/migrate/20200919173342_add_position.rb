class AddPosition < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :position, :integer, default: 0
  end
end
