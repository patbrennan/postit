class Post < ActiveRecord::Base
  PER_PAGE = 5

  include Voteable # includes file because autoload_paths added in application.rb
  include Sluggable
  
  default_scope { order('created_at ASC') }
  
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  validates :slug, uniqueness: true
  
  sluggable_column :title
  
  def as_json(*) # oveerride the API endpoint to expose only certain data
    super(only: [:url, :title, :description, :created_at]).tap do |hash|
      hash["votes"] = self.vote_count.to_s
      hash["author"] = self.user.username
      hash["comments"] = self.comments.as_json
    end
  end
end