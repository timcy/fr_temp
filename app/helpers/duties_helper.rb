module DutiesHelper

	def repeat_duty_options_for_select
    [	[ "Does not repeat", :never ],
    	[ "Daily", :tomorrow ],
      [ "Every Weekday (mon-fri)", :m_to_f ],
      [ "Every Mon, Wed, Fri", :m_w_f ],
      [ "Every Tue, Thu", :t_t ],
      [ "Weekly", :weekly ],
      [ "Monthly", :next_month ],
      [ "Yearly", :next_year ] ]
  end
end