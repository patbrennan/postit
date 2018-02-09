class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  # will prevent it from validating anything, so you can manually do validations
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  # only fire on creation of a user, not on update (so you don't have to type in password every time)
  validates :password, presence: true, length: {minimum: 5}, on: :create
  
  def to_param
    self.username
  end
end