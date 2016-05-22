class Gallary < ActiveRecord::Base
	belongs_to :event
	mount_uploader :image, ImageUploader
	validates :image, presence: true

end
