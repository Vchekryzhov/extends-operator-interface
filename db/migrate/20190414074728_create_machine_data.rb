class CreateMachineData < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_data do |t|
      t.references :machine
      t.jsonb :data
      t.timestamps
    end
  end
end
