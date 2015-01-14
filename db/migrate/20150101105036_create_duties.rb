class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
    	# t.integer  :coach_id
      t.integer  :owned_by_coach_id
      t.string   :name, limit: 200
      t.datetime :start_date    
      t.datetime :end_date
      t.boolean  :is_complete, default: false
      t.string   :urgency, limit: 10
      t.string   :display_in
      t.boolean  :send_reminder_emails, default: false
      t.text     :notes, limit: 8000
      t.timestamps null: false
    end
    add_index :duties, :owned_by_coach_id
    add_index :duties, [:start_date, :end_date]
  end
end


# t.string   :repeat, limit: 15
# A coach has many duties
# A duty belongs to a coach

