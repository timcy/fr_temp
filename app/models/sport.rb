class Sport < ActiveRecord::Base
	belongs_to :university
	has_and_belongs_to_many :coaches
end
