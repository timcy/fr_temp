class University < ActiveRecord::Base
	has_many :sports
	has_many :coaches
end
