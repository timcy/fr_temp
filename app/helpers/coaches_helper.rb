module CoachesHelper
	
	def coach_options_for_select( coach = Coach.last )
		# options = [ [ "All", coach.current_sport.coaches.pluck(:id) ] ]
		options = [ [ "All", 0 ] ]
		coach.current_sport.coaches.select(:id, :id).each do |coach|
			options << [ coach.name , coach.id ]
		end
		return options
  end
end
