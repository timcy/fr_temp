class CoachesSports < ActiveRecord::Migration
  def change
  	create_table :coaches_sports, id: false do |t|
    	t.integer :coach_id
    	t.integer :sport_id
    end
    add_index :coaches_sports, [:coach_id, :sport_id], name: "index_coaches_sports"
  end
end
