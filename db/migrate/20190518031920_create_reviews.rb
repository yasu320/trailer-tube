class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title, default: "", null:false
      t.text :content, default: "", null:false
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :video_id, :created_at]
  end
end
