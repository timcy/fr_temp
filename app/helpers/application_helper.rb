module ApplicationHelper

	# called from duties_controller/create
  def to_datetime( date, time="11:59 PM" )
  	# time ~> '10:20 pm'  	# date ~> '12/31/2015'
    # month, day, year = date.split('/')
    month, day, year = Date.strptime( date, "%m/%d/%Y" ).strftime("%m/%d/%Y").split('/')
    hour, minute = Time.strptime( time, "%I:%M %P").strftime("%H:%M").split(":")
    Time.zone.local( year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, 0 )
  end
end
