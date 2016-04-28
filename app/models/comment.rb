class Comment < ActiveRecord::Base
  belongs_to :event, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :event_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
