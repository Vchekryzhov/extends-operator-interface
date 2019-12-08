class CreateMachineDataIndex < ActiveRecord::Migration[5.2]
  def change
    add_index(:machine_data, :created_at)
  end
end
