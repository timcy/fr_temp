class DutiesController < ApplicationController

	def new
		@duty = Duty.new
	end

	def create
		coach = Coach.last  # Should be fetched from logged in user, or coach_id params. hardcoded currently
		# @duty = current_user.build_duty
		@duty = Duty.new( duty_params )
		# @duty.owned_by_coach_id = params[:coach_id] || current_user.coach_id
		@duty.start_date = to_datetime( @duty.start_day, @duty.start_time )
		@duty.end_date = to_datetime( @duty.end_day, @duty.end_time )
		@duty.repeat_till = to_datetime( @duty.repeat_till )
		if "0".in?(@duty.assign_to_coach_ids)
			@duty.assign_to_coach_ids = coach.current_sport.coaches.pluck(:id)
		else
			@duty.assign_to_coach_ids.reject!(&:empty?)
		end
		@duty.save
		render text: "Hello"
	end

  private

  def duty_params
    params.require(:duty).permit(:name, :urgency, :notes, :start_day, :start_time, :end_day, :end_time, :repeat, :repeat_till, assign_to_coach_ids:[],
    assign_to_player_ids: [] )
  end
end
