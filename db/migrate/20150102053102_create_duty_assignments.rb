class CreateDutyAssignments < ActiveRecord::Migration
  def change
    create_table :duty_assignments do |t|
      t.integer :duty_id
      t.integer :assignable_id
      t.string  :assignable_type
      t.string  :category, limit: 10
      t.timestamps null: false
    end
    add_index :duty_assignments, [:duty_id, :assignable_id, :assignable_type], name: "index_assigned_duties"
  end
end
