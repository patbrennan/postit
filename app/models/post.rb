class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  
  before_save :generate_slug
  
  def vote_count
    self.up_votes - self.down_votes
  end
  
  def up_votes
    self.votes.where(vote: true).size
  end
  
  def down_votes
    self.votes.where(vote: false).size
  end
  
  def generate_slug
    new_slug = self.title.gsub(/[\s[^a-zA-Z0-9]]/, "-").downcase
    new_slug = new_slug.gsub(/-{2,}/, "-")
    self.slug = new_slug
  end
  
  def to_param
    self.slug
  end
end