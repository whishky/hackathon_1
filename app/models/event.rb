class Event < ActiveRecord::Base

	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :user_id, presence: true
	validates :title,  presence: true, length: { maximum: 50 }
	validates :description,  presence: true, length: { maximum: 500 }
	validates :start_date_time,  presence: true, length: { maximum: 50 }
	validates :end_date_time,  presence: true, length: { maximum: 50 }
	validates :city,  presence: true, length: { maximum: 50 }
	validates :address,  presence: true, length: { maximum: 50 }
	validates :event_creater,  presence: true, length: { maximum: 50 }
end
