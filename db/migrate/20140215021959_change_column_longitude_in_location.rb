class ChangeColumnLongitudeInLocation < ActiveRecord::Migration
  def up
      
      change_column :locations, :longitude, :string
      change_column :locations, :latitude, :string
      
  end

  def down
      
      change_column :locations, :longitude, :integer
      change_column :locations, :latitude, :integer
      
  end
end
