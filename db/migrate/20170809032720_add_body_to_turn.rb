class AddBodyToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :body, :text
  end
end
