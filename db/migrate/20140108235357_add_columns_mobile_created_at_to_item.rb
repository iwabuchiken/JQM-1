class AddColumnsMobileCreatedAtToItem < ActiveRecord::Migration
  def self.up
    
    #REF data types // http://stackoverflow.com/questions/4685009/rails-3-datatypes answered Jun 27 '11 at 7:37
    add_column :items, :mobile_created_at, :integer
    add_column :items, :mobile_updated_at, :integer
    add_column :items, :mobile_posted_at, :integer
    
  end
  
  def self.down
  
    remove_column :items, :mobile_created_at, :integer
    remove_column :items, :mobile_updated_at, :integer
    remove_column :items, :mobile_posted_at, :integer
    
  end
end
