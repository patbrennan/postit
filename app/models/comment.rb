class Comment < ActiveRecord::Base
  include Voteable # able to pick up file because autoload_paths added in application.rb
  
  belongs_to :user
  belongs_to :post
  
  validates :body, presence: true, length: {maximum: 1000, minimum: 1}
end