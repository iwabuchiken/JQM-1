class AddColumnHistoryPaginationSizeToEnvNr4s < ActiveRecord::Migration
  def self.up
    
    add_column :env_nr4s, :history_pagination_size, :integer
    
  end
  
  def self.down
  
    remove_column :env_nr4s, :history_pagination_size, :integer
    
  end
end
