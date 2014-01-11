class AddColumnsMobileCreatedAtToItem < ActiveRecord::Migration
  def change
    
    #REF data types // http://stackoverflow.com/questions/4685009/rails-3-datatypes answered Jun 27 '11 at 7:37
    add_column :items, :mobile_created_at,  :string
    add_column :items, :mobile_updated_at,  :string
    add_column :items, :mobile_posted_at,   :string
    
  end
  
end
