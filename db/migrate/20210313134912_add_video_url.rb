class AddVideoUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :video_url, :string
  end
end
