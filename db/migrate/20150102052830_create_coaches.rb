class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.integer :university_id
      t.string  :address_line_1
      t.string  :address_line_2
      t.string  :city
      t.string  :state
      t.string  :zip, limit: 6
      t.string  :phone_number
      t.string  :cell_phone_number
      t.boolean :subscribe_to_sms_replies
      t.boolean :is_active
      t.boolean :is_compliance_officer
      t.boolean :is_admission_officer
      t.boolean :is_allowed_multiple_exports
      t.boolean :subscribe_to_athlete_questionnaires
      t.timestamps null: false
    end
  end
end
