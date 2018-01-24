class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  validates :body, presence: true, length: {maximum: 1000, minimum: 1}
end