class CreateDepart2devices < ActiveRecord::Migration[5.2]
  def change
    create_table :depart2devices do |t|
      t.references :department
      t.references :device
      t.timestamps
    end
  end
end
