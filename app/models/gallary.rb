class Gallary < ActiveRecord::Base
	belongs_to :event
	mount_uploader :image, ImageUploader
	validates :image, presence: true
  has_many :avgrating, dependent: :destroy
  has_many :gallaryrating, dependent: :destroy
end
