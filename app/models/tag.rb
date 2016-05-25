class Tag < ActiveRecord::Base
	has_many :taggings, dependent: :destroy
	has_many :events, through: :taggings
end
