class Comment < ActiveRecord::Base
  include Voteable # able to pick up file because autoload_paths added in application.rb
  
  belongs_to :user
  belongs_to :post
  
  validates :body, presence: true, length: {maximum: 1000, minimum: 1}
  
  def as_json(*)
    super(only: [:body, :created_at]).tap do |hash|
      hash["author"] = self.user.username
    end
  end
end