class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.jsonb :request
      t.timestamps
    end
  end
end
