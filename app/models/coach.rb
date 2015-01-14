class Coach < ActiveRecord::Base

	has_one :user, as: :role

	has_many :duty_assignments, as: :assignable
	has_many :duties, through: :duty_assignments

	has_and_belongs_to_many :sports
	belongs_to :university

	# Duties created by a coach
	has_many :owned_duties, class_name: 'Duty', foreign_key: 'owned_by_coach_id'

  delegate :first_name, :last_name, :user_name, :name, :to => :user, prefix: false, allow_nil: true
  delegate :first_name=, :last_name=, :user_name=, :name=, :to => :user, prefix: false, allow_nil: true


  # ToDo
  # Hardcoded currently
  def current_sport
  	Sport.first
  end
end