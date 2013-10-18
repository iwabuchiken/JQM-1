class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.text :line
      t.string :url
      t.string :vendor
      t.string :news_time
      t.string :genre
      t.string :cat
      t.string :subcat

      t.timestamps
    end
  end
  
    def down
    
        drop_table :articles
    
    end
    
end
