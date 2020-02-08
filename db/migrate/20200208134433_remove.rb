class Remove < ActiveRecord::Migration[5.2]
  def change
    drop_table :depart2devices
  end
end
