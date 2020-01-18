class CreateInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :inputs do |t|
      t.references :device
      t.references :group_input
      t.string :name
      t.string :values, array: true
      t.boolean :is_error, default: false
      t.string :message_error
      t.string :hint_error
      t.datetime :client_time
      t.references :request
      t.timestamps
    end
  end
end
