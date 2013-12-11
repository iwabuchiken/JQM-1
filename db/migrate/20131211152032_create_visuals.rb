class CreateVisuals < ActiveRecord::Migration
  def change
    create_table :visuals do |t|
      t.string :main

      t.timestamps
    end
  end
end
