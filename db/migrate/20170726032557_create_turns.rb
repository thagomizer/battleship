class CreateTurns < ActiveRecord::Migration[5.1]
  def change
    create_table :turns do |t|
      t.belongs_to :games, index: true
      t.integer :turn_id, index: true
      t.binary :state
      t.timestamps
    end
  end
end
