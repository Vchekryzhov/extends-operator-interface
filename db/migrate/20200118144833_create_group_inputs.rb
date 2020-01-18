class CreateGroupInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :group_inputs do |t|
      t.string :name
      t.timestamps
    end
  end
end
