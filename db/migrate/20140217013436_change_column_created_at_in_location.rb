class ChangeColumnCreatedAtInLocation < ActiveRecord::Migration
  def up
      
      change_column :locations, :m_created_at,  :string
      change_column :locations, :m_modified_at, :string
      
  end

  def down
      
      change_column :locations, :m_created_at,  :integer
      change_column :locations, :m_modified_at, :integer
      
  end
end
