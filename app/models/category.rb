class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  
  before_save :generate_slug
  
  def generate_slug
    new_slug = self.name.gsub(/[\s[^a-zA-Z0-9]]/, "-").downcase
    new_slug = new_slug.gsub(/-{2,}/, "-")
    self.slug = new_slug
  end
  
  def to_param
    self.slug
  end
end