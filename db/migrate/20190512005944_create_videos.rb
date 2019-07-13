class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :title, default: "", null:false
      t.string :url, default: "", null:false
      t.date :date, null:false
      t.text :description
      t.string :thumbnail, default: "", null:false

      t.timestamps
    end
  end
end
