class AddExtraColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :description, :text
    add_column :users, :birth_date, :date
    add_column :users, :sex, :integer
    add_column :users, :website, :string
  end
end
