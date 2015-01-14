class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
    	t.integer :university_id
    	t.string :name
      t.timestamps null: false
    end
    add_index :sports, :university_id
  end
end
