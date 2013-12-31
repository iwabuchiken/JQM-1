class CreateEqms < ActiveRecord::Migration
  def change
    create_table :eqms do |t|
      t.string :main
      t.string :sub1
      t.string :sub1

      t.timestamps
    end
  end
end
