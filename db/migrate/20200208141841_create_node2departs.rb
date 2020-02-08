class CreateNode2departs < ActiveRecord::Migration[5.2]
  def change
    create_table :node2departs do |t|
      t.references :node
      t.references :department
      t.timestamps
    end
  end
end
