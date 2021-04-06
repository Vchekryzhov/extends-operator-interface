class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :ivedion_src, :string
  end
end
