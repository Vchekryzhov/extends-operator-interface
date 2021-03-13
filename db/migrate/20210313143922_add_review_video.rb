class AddReviewVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :video, :string
  end
end
