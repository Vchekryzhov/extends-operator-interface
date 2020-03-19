class ValuesToValue < ActiveRecord::Migration[5.2]
  def change
    change_column :inputs, :values, :string
    rename_column :inputs, :values, :value
  end
end
