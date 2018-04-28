class AddColumnAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :author, :string
  end
end
