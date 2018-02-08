class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  # will prevent it from validating anything, so you can manually do validations
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  # only fire on creation of a user, not on update (so you don't have to type in password every time)
  validates :password, presence: true, length: {minimum: 5}, on: :create
  
  before_save :generate_slug
  
  # def generate_slug
  #   new_slug = self.username.gsub(/[\s[^a-zA-Z0-9]]/, "-").downcase
  #   new_slug = new_slug.gsub(/-{2,}/, "-")
  #   self.slug = new_slug
  # end
  
  def to_param
    self.username
  end
end