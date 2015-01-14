class Duty < ActiveRecord::Base


	has_many :assignees, :class_name => 'DutyAssignment'
	has_many :coaches, through: :assignees

	# For identifying the owner of the duty
	belongs_to	:owner, class_name: 'Coach', foreign_key: 'owned_by_coach_id'

	attr_accessor :start_day, :start_time, :end_day, :end_time, :repeat, :repeat_till, :assign_to_coach_ids, :assign_to_player_ids	

  before_save :build_duty_assignments_for_coaches, :build_duty_assignments_for_players


  after_create :create_recurring_duties, unless: :repeat_never?


  # Check whether a duty repeats or not.
  # == Calls:
  # None
  # 
  # == Called By: 
  # duty.rb/after_create callback
  # 
  # == Returns:
  # true or false
  def repeat_never?
    self.repeat == 'never' || self.repeat == nil
  end


  # Method to build Duty Assignments for Coaches, before creation of a duty.
  # == Calls:
  # duty.rb/build_duty_assignments(,)
  # 
  # == Called By: 
  # duty.rb/before_save callback
  # 
  # == Returns:
  # Void
  def build_duty_assignments_for_coaches
    build_duty_assignments( self.assign_to_coach_ids || [], "Coach" )
  end

  # Method to build Duty Assignments for Players, before creation of a duty.
  # == Calls:
  # duty.rb/build_duty_assignments(,)
  # 
  # == Called By: 
  # duty.rb/before_save callback
  # 
  # == Returns:
  # Void
  def build_duty_assignments_for_players
    build_duty_assignments( self.assign_to_player_ids || [] , "Player" )
  end

  # Method to build Duty Assignments for Coaches, before creation of a duty.
  # == Calls:
  # None
  # 
  # == Called By: 
  # duty.rb/build_duty_assignments_for_players
  # duty.rb/build_duty_assignments_for_coaches
  # 
  # == Returns:
  # Void
  def build_duty_assignments( resource_ids, resource_type )
    resource_ids.each do |resource_id|
      self.assignees.build( assignable_id: resource_id, assignable_type: resource_type, category: "HardCoded" )
    end
  end




  protected


  # Method to create recurring duties in DB, after a new duty is created
	# == Calls:
	# duty.rb/set_recurring_duty_attributes
  # 
  # == Called By: 
	# duty.rb/after_create callback
  # 
  # == Returns:
  # Void
  def create_recurring_duties
  	# Expected values for repeat - tomorrow, m_w_f, t_t, m_to_f, next_month, weekly, next_year
    start = self.start_date.to_date
    finish = self.repeat_till

    if self.repeat.in?( ["tomorrow", "next_month", "next_year"] )
      while ( start.send("#{self.repeat}") <= finish ) do
        recurring_duty = set_recurring_duty_attributes( start.send("#{self.repeat}") )
        recurring_duty.save
        start = start.send("#{self.repeat}")
      end
    elsif self.repeat.in?( ["m_w_f", "t_t", "m_to_f", "weekly"] )
    	mon = 1.day + ((0-start.wday) % 7).days
    	tue = 1.day + ((1-start.wday) % 7).days
    	wed = 1.day + ((2-start.wday) % 7).days
    	thu = 1.day + ((3-start.wday) % 7).days
    	fri = 1.day + ((4-start.wday) % 7).days
    	sat = 1.day + ((5-start.wday) % 7).days
    	sun = 1.day + ((6-start.wday) % 7).days
    	case "#{self.repeat}"
	    	when "m_w_f" 	then duty_days = [] << mon << wed << fri
	    	when "t_t" 	 	then duty_days = [] << tue << thu
	    	when "m_to_f" then duty_days = [] << mon << tue << wed << thu << fri
	    	when "weekly" then duty_days = [] << 7.days
    	end
      duty_days.each do |next_duty_day|
        while ( (start + next_duty_day) <= finish ) do
          recurring_duty = set_recurring_duty_attributes( start + next_duty_day )
          recurring_duty.save
          start += 7.days
        end
        start = self.start_date.to_date
      end
    end
  end

  # Method to build recurring duty objects, after a new duty is created
	# == Calls:
	# None
  # 
  # == Called By: 
	# duty.rb/create_recurring_duties
  # 
  # == Returns:
  # Duty object
  def set_recurring_duty_attributes( start_date )
    rd = Duty.new( name: self.name, urgency: self.urgency, display_in: self.display_in, send_reminder_emails: self.send_reminder_emails, notes: self.notes, owned_by_coach_id: self.owned_by_coach_id,
                   assign_to_player_ids: self.assign_to_player_ids, assign_to_coach_ids: self.assign_to_coach_ids )
    rd.start_date = start_date
    rd.start_date = rd.start_date.change(hour: self.start_date.hour, min: self.start_date.min )
    # Setting the end_date based on the difference in days between original start_date and end_date
    rd.end_date = rd.start_date + (self.end_date.to_date - self.start_date.to_date).to_i
    rd.end_date = rd.end_date.change(hour: self.end_date.hour, min: self.end_date.min )
    return rd
  end

end
