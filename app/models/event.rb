class Event < ActiveRecord::Base
	validates :title,  presence: true, length: { maximum: 50 }
	validates :description,  presence: true, length: { maximum: 500 }
	validates :start_date_time,  presence: true, length: { maximum: 50 }
	validates :end_date_time,  presence: true, length: { maximum: 50 }
	validates :city,  presence: true, length: { maximum: 50 }
	validates :address,  presence: true, length: { maximum: 50 }
	validates :event_creater,  presence: true, length: { maximum: 50 }
end
