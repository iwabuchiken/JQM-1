class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :m_id
      t.integer :m_created_at
      t.integer :m_modified_at
      t.integer :longitude
      t.integer :latitude
      t.text :memo

      t.timestamps
    end
  end
end
