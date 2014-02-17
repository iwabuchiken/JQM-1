class AddColumnCreatedAtNewInLocation < ActiveRecord::Migration
  def change
      
      add_column :locations, :m_created_at_new,  :string
      
  end

end
