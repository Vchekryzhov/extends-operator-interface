class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :title
      t.string :image
      t.string :preview_description
      t.string :description
      t.timestamps
    end
  end
end
