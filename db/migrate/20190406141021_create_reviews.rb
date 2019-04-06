class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :youtube_url
      t.references :machine
      t.timestamps
    end
  end
end
