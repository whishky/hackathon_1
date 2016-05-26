class Gallaryrating < ActiveRecord::Base
  belongs_to :gallary
  belongs_to :user
end
