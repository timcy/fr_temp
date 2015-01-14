class DutyAssignment < ActiveRecord::Base
	belongs_to :duty
	belongs_to :assignable, polymorphic: true
end
